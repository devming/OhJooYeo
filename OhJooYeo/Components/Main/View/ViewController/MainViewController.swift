//
//  ViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 4. 28..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import RxSwift
import RxCocoa

enum UIConstantValue: CGFloat {
    case tableViewCellHeight = 80.0
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var dateHistoryButton: UIButton!
    @IBOutlet weak var yearlyPhraseLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var nextMainPresenterLabel: UILabel!
    @IBOutlet weak var nextPrayerLabel: UILabel!
    @IBOutlet weak var nextOfferLabel: UILabel!
    
    
    
    let refreshControl = UIRefreshControl()
    var activityIndicator: NVActivityIndicatorView?
    
    let viewModel = WorshipMainInfoViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// test code
        WorshipManager.shared.date = "2019-11-07"
            
        
        setupUI()
        setupData()
    }
    
    func setupUI() {
        initRefreshControl()
        self.activityIndicator = NVActivityIndicatorView(frame: self.view.frame, type: NVActivityIndicatorType.ballTrianglePath, color: UIColor.white, padding: self.view.frame.width / 2.5)
        self.view.addSubview(self.activityIndicator!)
        
        self.listTableView.rowHeight = UITableViewAutomaticDimension
        self.listTableView.layer.cornerRadius = 10.0
        
        setTransparentBackground(navigationController: self.navigationController)
        
        self.activityIndicator?.startAnimating()
    }
    
    func setupData() {
        loadDatas()
        WorshipApiHelper.requestYearlyMessage()
            .bind(to: self.yearlyPhraseLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.reloadAction()
    }
    
    @IBAction func dateHistoryTapped(_ sender: Any) {
        performSegue(withIdentifier: SegueName.historySegue.rawValue, sender: sender)
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orderList = viewModel.worshipInfo?.worshipOrderList else {
            return 0
        }
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orderList = viewModel.worshipInfo?.worshipOrderList else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderRowCell.cellName, for: indexPath) as? OrderRowCell else {
            return UITableViewCell()
        }
        
        cell.setItem(item: orderList[indexPath.row])
        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstantValue.tableViewCellHeight.rawValue
    }
}

/// Custom Methods
extension MainViewController {
    
    func initRefreshControl() {
        self.refreshControl.rx.controlEvent(.valueChanged)
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.loadDatas()
            }).disposed(by: disposeBag)
//        self.refreshControl.addTarget(self, action: #selector(), for: .valueChanged)
        self.listTableView.addSubview(self.refreshControl)
    }
    
    func bindNextPresenter(nextPresenter: NextPresenter?) {
        self.nextMainPresenterLabel.text = nextPresenter?.mainPresenter
        self.nextPrayerLabel.text = nextPresenter?.prayer
        self.nextOfferLabel.text = nextPresenter?.offer
    }
    
    @objc func loadDatas() {

        setBackgroundSubViewsHide(isHidden: true)
        
        /// [TestCode]
//        let worshipId = "19-003"
        let worshipDate = WorshipManager.shared.date
//        guard let worshipId = worshipId else {
//            self.reloadAction(isSuccess: false)
//            return
//        }
        self.activityIndicator?.startAnimating()
        

        let recentWorshipInfoOb = viewModel.requestWorshipList(churchId: WorshipManager.shared.churchId)
            .filter { $0.count > 0 }
            .do(onNext: { recentWorshipInfoList in
                WorshipManager.shared.setCurrentWorshipId(worshipIdList: recentWorshipInfoList)
            })
            .map { $0.first! }
            
        recentWorshipInfoOb
            .concatMap(viewModel.requestWorshipMain)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] worshipMainInfo in
                self?.dateLabel.text = worshipDate
                self?.bindNextPresenter(nextPresenter: worshipMainInfo.nextPresenter)
                self?.reloadAction()
                }, onError: { [weak self] err in
                    print("#### ERROR: \(err)")
                    self?.reloadAction(isSuccess: false)
            }).disposed(by: disposeBag)
        
//        self.viewModel.requestWorshipMain(worshipId: worshipId ?? "", worshipDate: worshipDate)
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] worshipMainInfo in
//                self?.dateLabel.text = worshipDate
//                self?.bindNextPresenter(nextPresenter: worshipMainInfo.nextPresenter)
//                self?.reloadAction()
//                }, onError: { [weak self] err in
//                    print("#### ERROR: \(err)")
//                    self?.reloadAction(isSuccess: false)
//            }).disposed(by: disposeBag)
        //        }
    }
    
    func reloadAction(isSuccess: Bool = true) {
        self.listTableView.reloadData()
        self.activityIndicator?.stopAnimating()
        self.refreshControl.endRefreshing()
        if !isSuccess {
            self.backgroundView.showErrorView(.network) { [weak self] in
                self?.loadDatas()
            }
            
            return
        }
        setBackgroundSubViewsHide(isHidden: false)
        let date = WorshipApiHelper.requestDate()
        self.dateLabel.text = date
    }
    
    func setBackgroundSubViewsHide(isHidden: Bool) {
        self.backgroundView.subviews.forEach {
            $0.isHidden = isHidden
//            $0.alpha = isHidden ? 0.0 : 1.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let cell = sender as? OrderRowCell,
            let indexPath = self.listTableView.indexPath(for: cell) {
            
            guard let orderList = viewModel.worshipInfo?.worshipOrderList, orderList[indexPath.row].type == WorshipOrder.TypeName.phrase.rawValue else {
                return
            }
            
            
            if let destination = segue.destination as? PhraseDetailViewController {
                destination.orderId = Int(orderList[indexPath.row].orderId)
                destination.phraseRange = orderList[indexPath.row].detail
            }
            cell.setSelected(false, animated: true)
        }
        
        if let _ = sender as? UIButton, let vc = segue.destination as? HistoryViewController {
            vc.mainViewModel = self.viewModel
        }
    }
}

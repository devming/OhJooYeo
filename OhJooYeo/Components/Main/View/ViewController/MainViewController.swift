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

class MainViewController: BaseViewController {
    
    @IBOutlet weak var mainPresenterLabel: UILabel!
    
    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var dateHistoryButton: UIButton!
    @IBOutlet weak var yearlyPhraseLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var nextMainPresenterLabel: UILabel!
    @IBOutlet weak var nextPrayerLabel: UILabel!
    @IBOutlet weak var nextOfferLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    
    let viewModel = WorshipMainInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// test code
//        WorshipManager.shared.date = "2019-11-07"
        
        setupUI()
        setupData()
    }
    
    func setupUI() {
        initRefreshControl()
        
        self.listTableView.rowHeight = UITableViewAutomaticDimension
        self.listTableView.layer.cornerRadius = 10.0
        
        setTransparentBackground()
        
        self.activityIndicator?.startAnimating()
    }
    
    func setupData() {
        loadDatas()
        WorshipApiHelper.requestYearlyMessage()
            .bind(to: self.yearlyPhraseLabel.rx.text)
            .disposed(by: disposeBag)
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
        return viewModel.worshipInfo?.worshipOrderList.count ?? 0
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
        self.listTableView.addSubview(self.refreshControl)
    }
    
    func bindNextPresenter(nextPresenter: NextPresenter?) {
        self.nextMainPresenterLabel.text = nextPresenter?.mainPresenter
        self.nextPrayerLabel.text = nextPresenter?.prayer
        self.nextOfferLabel.text = nextPresenter?.offer
    }
    
    @objc func loadDatas() {
        setBackgroundSubViewsHide(isHidden: true)
        self.activityIndicator?.startAnimating()

        /// 1. 로그인해서 가져온 churchId로 worshipList 가져옴.
        viewModel.requestWorshipList(churchId: WorshipManager.shared.churchId)
            .filter { $0.count > 0 }
            .do(onNext: { recentWorshipInfoList in
                /// 2. worshipList로 가져온 응답 데이터를 WorshipManager 싱글턴에 저장

                /// 날짜 내림차순 정렬
                let sortedList = recentWorshipInfoList.sorted { $0.worshipId > $1.worshipId }
                
                WorshipManager.shared.setRecentWorshipId(worshipIdList: sortedList, index: 0)
            })
            .map { $0.first! }
            /// 3. 첫번째 데이터로 worship 정보 요청
            .concatMap(viewModel.requestWorshipMain)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                guard let worshipMainInfo = data, worshipMainInfo.worshipOrderList.count != 0 else {
                    self?.backgroundView.showErrorView(.data) { [weak self] in
                        self?.reloadAction(errorType: .data)
                    }
                    return 
                }
                if let mainPresenter = worshipMainInfo.mainPresenter {
                    self?.mainPresenterLabel.text = "인도자: \(mainPresenter)"
                } else {
                    self?.mainPresenterLabel.text = "인도자: ---"
                }
                self?.dateLabel.text = WorshipManager.shared.currentDate
                self?.bindNextPresenter(nextPresenter: worshipMainInfo.nextPresenter)
                self?.reloadAction(errorType: .success)
                }, onError: { [weak self] err in
                    self?.reloadAction(errorType: .network)
            }).disposed(by: disposeBag)
    }
    
    func reloadAction(errorType: OJYError) {
        self.listTableView.reloadData()
        self.activityIndicator?.stopAnimating()
        self.refreshControl.endRefreshing()
        if errorType != .success {
            self.backgroundView.showErrorView(errorType) { [weak self] in
                self?.loadDatas()
            }
            return
        }
        setBackgroundSubViewsHide(isHidden: false)
        let date = WorshipApiHelper.requestDate()
        self.dateLabel.text = date
    }
    
    func setBackgroundSubViewsHide(isHidden: Bool) {
        self.listTableView.subviews.forEach {
            $0.isHidden = isHidden
        }
        self.dateHistoryButton.isHidden = isHidden
        self.dateLabel.isHidden = isHidden
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

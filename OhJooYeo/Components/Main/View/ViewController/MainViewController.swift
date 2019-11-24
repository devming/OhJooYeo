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
    
    @IBOutlet var backgroundView: BackgroundView!
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
        
        setupUI()
        setupData()
    }
    
    func setupUI() {
        self.activityIndicator = NVActivityIndicatorView(frame: self.view.frame, type: NVActivityIndicatorType.ballTrianglePath, color: UIColor.white, padding: self.view.frame.width / 2.5)
        self.view.addSubview(self.activityIndicator!)
        
        self.listTableView.rowHeight = UITableViewAutomaticDimension
        self.listTableView.layer.cornerRadius = 10.0
        
        initRefreshControl()
        setTransparentBackground(navigationController: self.navigationController)
    }
    
    func setupData() {
        loadDatas()
        WorshipApiHelper.requestYearlyMessage()
            .bind(to: self.yearlyPhraseLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.reloadAction()
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
//    func tableView(_ tableView: UITableView,
//                   heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 2 {
//            return 250
//        }
//        return UITableViewAutomaticDimension
//    }
//
//    func tableView(_ tableView: UITableView,
//                   estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 50.0
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        if section == 0 {
//            
//            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FirstSectionHeader.headerName) as? FirstSectionHeader else { return nil }
//            
//            viewModel.worshipInfoObservable
//                .asDriver(onErrorJustReturn: nil)
//                .drive(onNext: { worshipInfo in
//                    headerView.setMainPresenter(mainPresenter: worshipInfo?.mainPresenter)
//                }).disposed(by: disposeBag)
//            return headerView
//        }
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TextSectionHeader.headerName) as? TextSectionHeader else { return nil }
//
//        viewModel.worshipInfoObservable
//            .asDriver(onErrorJustReturn: nil)
//            .drive(onNext: { _ in
//                var title = ""
//                if section == 1 {
//                    title = "다음주 예배섬김"
//                } else {
//                    title = "올해의 말씀"
//                }
//                headerView.setTitle(text: title)
//            }).disposed(by: disposeBag)
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstantValue.tableViewCellHeight.rawValue
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        let naviHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0
//        print("height: \(naviHeight)")
//        let screenHeight: CGFloat = UIScreen.main.bounds.height
//        let tableItemsHeight: CGFloat = UIConstantValue.tableViewCellHeight.rawValue * CGFloat((viewModel.worshipInfo?.worshipOrderList.count ?? 0))
//        let dateHistoryHeight: CGFloat = dateHistoryButton.frame.height + 30 // 30 = vertical constraint
//        let footerHeight: CGFloat = screenHeight - naviHeight + tableItemsHeight + dateHistoryHeight
//        print("screenHeight: \(footerHeight)")
////        let footerHeight: CGFloat = UIScreen.main.bounds.height - (UIConstantValue.tableViewCellHeight.rawValue * (viewModel.worshipInfo?.worshipOrderList.count ?? 0) + naviHeight + dateHistoryButton.frame.height + 30)
//        return footerHeight
//    }
}

/// Custom Methods
extension MainViewController {
    //    @objc func worshipUpdate(_ notification: Notification) {
    //        updateWorship()
    //    }
    //
    //    func updateWorship() {
    //        OperationQueue.main.addOperation { [weak self] in
    //            guard let `self` = self else { return }
    //            if App.isLoadingComplete {
    //                self.dateHistoryButton.setTitle(" \(WorshipManager.shared.date)", for: .normal)
    //                self.activityIndicator?.stopAnimating()
    //                self.listTableView.reloadData()
    //                self.mainPresenterLabel.text = "인도자: \(self.viewModel.worshipInfo?.mainPresenter ?? "OOO")"
    //                App.isLoadingComplete = false
    //            } else {
    ////                let errorView = NetworkErrorView(frame: self.view.frame)
    ////                self.view.addSubview(errorView)
    //                self.backgroundView.showErrorView(.network) {
    ////                    self.yearlyMessage.isHidden = true
    //                    self.dateHistoryButton.isHidden = true
    //                    self.listTableView.isHidden = true
    ////                    self.mainPresenterLabel.isHidden = true
    ////                    self.standupLabel.isHidden = true
    //                }
    //                self.activityIndicator?.stopAnimating()
    //            }
    //        }
    //    }
    
    func initRefreshControl() {
        self.refreshControl.addTarget(self, action: #selector(loadDatas), for: .valueChanged)
        self.listTableView.addSubview(self.refreshControl)
    }
    
    func bindNextPresenter(nextPresenter: NextPresenter?) {
        self.nextMainPresenterLabel.text = nextPresenter?.mainPresenter
        self.nextPrayerLabel.text = nextPresenter?.prayer
        self.nextOfferLabel.text = nextPresenter?.offer
    }
    
    @objc func loadDatas(worshipId: String? = WorshipManager.shared.currentWorshipInfo?.worshipId) {
        
        let date = WorshipApiHelper.requestDate()
        self.dateLabel.text = date
        
        /// [TestCode]
        let worshipId = "19-003"
//        guard let worshipId = worshipId else {
//            self.reloadAction(isSuccess: false)
//            return
//        }
        self.activityIndicator?.startAnimating()
        viewModel.requestWorshipMain(worshipId: worshipId)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] worshipMainInfo in
                self?.bindNextPresenter(nextPresenter: worshipMainInfo.nextPresenter)
                self?.reloadAction()
                }, onError: { [weak self] err in
                    print("#### ERROR: \(err)")
                    self?.reloadAction(isSuccess: false)
            }).disposed(by: disposeBag)
        //        }
    }
    
    func reloadAction(isSuccess: Bool = true) {
        self.listTableView.reloadData()
        self.activityIndicator?.stopAnimating()
        if !isSuccess {
            self.backgroundView.showErrorView(.network) { [weak self] in
                self?.loadDatas()
            }
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
        }
        
        if let _ = sender as? UIButton, let vc = segue.destination as? HistoryViewController {
            vc.mainViewModel = self.viewModel
        }
    }
}

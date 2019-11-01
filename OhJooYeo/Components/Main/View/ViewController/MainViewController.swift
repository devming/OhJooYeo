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

class MainViewController: UIViewController {
    
    @IBOutlet var backgroundView: BackgroundView!
    @IBOutlet weak var listTableView: UITableView!
//    @IBOutlet weak var yearlyMessage: UITextView!
//    @IBOutlet weak var mainPresenterLabel: UILabel!
    @IBOutlet weak var dateHistoryButton: UIButton!
//    @IBOutlet weak var standupLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    var activityIndicator: NVActivityIndicatorView?
    
    let viewModel = WorshipMainInfoViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.yearlyMessage.layer.cornerRadius = 3.0
        self.activityIndicator = NVActivityIndicatorView(frame: self.view.frame, type: NVActivityIndicatorType.ballTrianglePath, color: UIColor.white, padding: self.view.frame.width / 2.5)
        self.view.addSubview(self.activityIndicator!)
        self.activityIndicator?.startAnimating()
        
        self.listTableView.rowHeight = UITableViewAutomaticDimension
        self.listTableView.layer.cornerRadius = 10.0
        self.listTableView.register(FirstSectionHeader.self, forHeaderFooterViewReuseIdentifier: FirstSectionHeader.headerName)
        self.listTableView.register(NextPresenterSectionHeader.self, forHeaderFooterViewReuseIdentifier: NextPresenterSectionHeader.headerName)
       
        
        initRefreshControl()
        
        setTransparentBackground(navigationController: self.navigationController)
        
        reloadDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listTableView.reloadData()
    }
    @IBAction func dateHistoryTapped(_ sender: Any) {
        performSegue(withIdentifier: SegueName.historySegue.rawValue, sender: sender)
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orderList = viewModel.worshipInfo?.worshipOrderList else {
            return 0
        }
        
        if section == 0 {
            return orderList.count
        } else if section == 1 {
            return 1
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orderList = viewModel.worshipInfo?.worshipOrderList,
            let nextPresenter = viewModel.worshipInfo?.nextPresenter else { return UITableViewCell() }
//        guard let orderList = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.worshipOrderList,
//            let nextPresenter = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.nextPresenter?.mainPresenter,
//            let nextPrayer = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.nextPresenter?.prayer,
//            let nextOffer = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.nextPresenter?.offer else {
//                print("orderList is null")
//                return UITableViewCell()
//        }
        if indexPath.section == 0 {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderRowCell.cellName) as? OrderRowCell else {
                return UITableViewCell()
            }
            
            cell.setItem(item: orderList[indexPath.row])
            return cell
        } else if indexPath.section == 1 {
         
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NextPresenterRowCell.cellName) as? NextPresenterRowCell else {
                return UITableViewCell()
            }
            
            cell.setItem(item: nextPresenter)
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NextPresenterSectionHeader.headerName) as? NextPresenterSectionHeader else { return nil }
            
            return headerView
        }
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FirstSectionHeader.headerName) as? FirstSectionHeader else { return nil }
        
        viewModel.mainPresenterObservable
            .asDriver(onErrorJustReturn: " ")
            .drive(onNext: { mainPresenter in
                headerView.setMainPresenter(mainPresenter: mainPresenter) 
            }).disposed(by: disposeBag)
//            .bind(to: headerView.mainPresenterLabel!.rx.text)
//            .disposed(by: disposeBag)
//        headerView.mainPresenterLabel.rx.text
            
//        headerView.setMainPresenter(mainPresenter: viewModel.worshipInfo?.mainPresenter)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let worshipOrderList = viewModel.worshipInfo?.worshipOrderList else {
            return 80
        }
        if indexPath.row == worshipOrderList.count {
            return 128
        }
        //        if worshipOrderList[indexPath.row].title == "성경봉독" || worshipOrderList[indexPath.row].title == "특송" {
        //            return 100
        //        }
        
        return 80
    }
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
//        viewModel.
        self.refreshControl.addTarget(self, action: #selector(reloadDatas), for: .valueChanged)
//        self.refreshControl.rx.
        self.listTableView.addSubview(self.refreshControl)
    }
    
    @objc func reloadDatas() {
        /// [TestCode]
//        if let worshipId = WorshipManager.shared.currentWorshipInfo?.worshipId {
        let worshipId = "19-001"
            viewModel.callApi(worshipId: worshipId)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] _ in
                    self?.listTableView.reloadData()
                    self?.activityIndicator?.stopAnimating()
                }, onError: { [weak self] err in
                    print("#### ERROR: \(err)")
                    self?.activityIndicator?.stopAnimating()
                    self?.backgroundView.showErrorView(.network) {
                        self?.reloadDatas()
                    }
                }).disposed(by: disposeBag)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let cell = sender as? OrderRowCell, let indexPath = self.listTableView.indexPath(for: cell) {
            
            guard let orderList = viewModel.worshipInfo?.worshipOrderList, orderList[indexPath.row].type == WorshipOrder.TypeName.phrase.rawValue else {
                return
            }
            
            if let destination = segue.destination as? PhraseDetailViewController {
                destination.orderId = Int(orderList[indexPath.row].orderId)
            }
        }
        
        if let _ = sender as? UIButton, let vc = segue.destination as? HistoryViewController {
            vc.mainViewModel = self.viewModel
        }
    }
}

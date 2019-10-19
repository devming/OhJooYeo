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
    @IBOutlet weak var yearlyMessage: UITextView!
    @IBOutlet weak var mainPresenterLabel: UILabel!
    @IBOutlet weak var dateHistoryButton: UIButton!
    @IBOutlet weak var standupLabel: UILabel!
    
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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(worshipUpdate), name: .WorshipDidUpdated, object: nil)
        
        initRefreshControl()
        
        setTransparentBackground(navigationController: self.navigationController)
        
        reloadDatas()
//        updateWorship()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listTableView.reloadData()
    }
    @IBAction func dateHistoryTapped(_ sender: Any) {
        print("Tapped")
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orderList = viewModel.worshipInfo?.worshipOrderList else {
            return 0
        }
        
        return orderList.count + 1
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
        
        switch indexPath.row {
        case 0..<orderList.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellName) as? OrderTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setItem(item: orderList[indexPath.row])
            return cell
            
        case orderList.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NextPresenterTableViewCell.cellName) as? NextPresenterTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setItem(item: nextPresenter)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return Bundle.main.loadNibNamed("NextPresenterSectionHeader", owner: self, options: nil)?.first as? NextPresenterSectionHeader
        }
        let firstView = FirstSectionHeader(frame: CGRect.zero)
        firstView.setMainPresenter(mainPresenter: viewModel.worshipInfo?.mainPresenter)
        return firstView
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
        viewModel.bindWorshipMainInfo()
            .subscribe(onNext: { _ in
                self.listTableView.reloadData()
            }).disposed(by: disposeBag)
//        DispatchQueue.main.async {
//            App.loadAllDataFromServer { [weak self] in
//                App.isLoadingComplete = true
//                self?.refreshControl.endRefreshing()
//                NotificationCenter.default.post(name: .WorshipDidUpdated, object: nil)
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let cell = sender as? OrderTableViewCell, let indexPath = self.listTableView.indexPath(for: cell) {
            
            guard let orderList = viewModel.worshipInfo?.worshipOrderList, orderList[indexPath.row].type == WorshipOrder.TypeName.phrase.rawValue else {
                return
            }
            
            if let destination = segue.destination as? PhraseDetailViewController {
                destination.orderID = Int(orderList[indexPath.row].orderID)
            }
        }
    }
}

//
//  ViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 4. 28..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MainViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    var activityIndicator: NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator = NVActivityIndicatorView(frame: self.view.frame, type: NVActivityIndicatorType.ballTrianglePath, color: UIColor.gray, padding: self.view.frame.width / 2.5)
        self.view.addSubview(self.activityIndicator!)
        self.activityIndicator?.startAnimating()
        
        self.listTableView.rowHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(worshipUpdate(_:)), name: .WorshipDidUpdated, object: nil)
        
        initRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listTableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orderList = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.worshipOrders else {
            print("orderList count is 0")
            return 0
        }
        
        return orderList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orderList = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.worshipOrders,
            let nextPresenter = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.nextPresenter?.mainPresenter,
            let nextPrayer = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.nextPresenter?.prayer,
            let nextOffer = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.nextPresenter?.offer else {
                print("orderList is null")
                return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0..<orderList.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellName) as? OrderTableViewCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = orderList[indexPath.row].title
            cell.detailLabel.text = orderList[indexPath.row].detail
            cell.presenterLabel.text = orderList[indexPath.row].presenter
            
            // 이동해야할 아이템의 경우 여기에서 조건 설정
            if orderList[indexPath.row].type == WorshipOrder.TypeName.phrase.rawValue { /// + 다른 타입들
                cell.accessoryType = .disclosureIndicator
            } else {
                cell.isUserInteractionEnabled = false
            }
            
            return cell
            
        case orderList.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NextPresenterTableViewCell.cellName) as? NextPresenterTableViewCell else {
                return UITableViewCell()
            }
            
            cell.mainPresenterLabel.text = nextPresenter
            cell.prayerLabel.text = nextPrayer
            cell.offerLabel.text = nextOffer
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let worshipOrderList = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.worshipOrders else {
            return 50
        }
        if indexPath.row == worshipOrderList.count {
            return 128
        }
        //        if worshipOrderList[indexPath.row].title == "성경봉독" || worshipOrderList[indexPath.row].title == "특송" {
        //            return 100
        //        }
        
        return 50
    }
}

/// Custom Methods
extension MainViewController {
    @objc func worshipUpdate(_ notification: Notification) {
        OperationQueue.main.addOperation { [weak self] in
            if App.isLoadingComplete {
                self?.dateLabel.text = WorshipMainInfoViewModel.shared.dateInfo
                self?.activityIndicator?.stopAnimating()
                self?.listTableView.reloadData()
                App.isLoadingComplete = false
            }
        }
    }
    
    func initRefreshControl() {
        self.refreshControl.addTarget(self, action: #selector(reloadDatas), for: .valueChanged)
        self.listTableView.addSubview(self.refreshControl)
    }
    
    @objc func reloadDatas() {
        DispatchQueue.main.async {
            App.loadAllDataFromServer { [weak self] in
                App.isLoadingComplete = true
                self?.refreshControl.endRefreshing()
                NotificationCenter.default.post(name: .WorshipDidUpdated, object: nil)
            }
            //            App.api.getWorshipIdList {
            //                //GlobalState.shared.recentWorshipID
            //                //GlobalState.shared.version
            //                App.api.getRecentDatas(worshipID: GlobalState.shared.recentWorshipID, version: GlobalState.shared.localVersion) { [weak self] in
            //                    self?.listTableView.reloadData()
            //                    self?.refreshControl.endRefreshing()
            //                }
            //            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let cell = sender as? OrderTableViewCell, let indexPath = self.listTableView.indexPath(for: cell) {
            guard let orderList = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.worshipOrders, orderList[indexPath.row].type == WorshipOrder.TypeName.phrase.rawValue else {
                return
            }
            
            if let destination = segue.destination as? PhraseDetailViewController {
                destination.orderID = Int(orderList[indexPath.row].orderID)
            }
        }
    }
}

//
//  ViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 4. 28..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        guard let orderList = WorshipMainInfoViewModel.shared.worshipOrderDataResults else {
            return 0
        }
        
        return orderList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orderList = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.worshipOrders,
            let nextPresenter = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.nextPresenter?.mainPresenter,
            let nextPrayer = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.nextPresenter?.prayer,
            let nextOffer = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.nextPresenter?.offer else {
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
            self?.dateLabel.text = WorshipMainInfoViewModel.shared.dateInfo
            self?.listTableView.reloadData()
        }
    }
    
    func initRefreshControl() {
        self.refreshControl.addTarget(self, action: #selector(reloadDatas), for: .valueChanged)
        self.listTableView.addSubview(self.refreshControl)
    }
    
    @objc func reloadDatas() {
        DispatchQueue.main.async { [weak self] in
            self?.listTableView.reloadData()
            self?.refreshControl.endRefreshing()
            //            App.api.getWorshipIdList {
            //                //GlobalState.shared.recentWorshipId
            //                //GlobalState.shared.version
            //                App.api.getRecentDatas(worshipId: GlobalState.shared.recentWorshipId, version: GlobalState.shared.localVersion) { [weak self] in
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
                destination.orderId = Int(orderList[indexPath.row].orderId)
                print("##")
            }
        }
    }
}

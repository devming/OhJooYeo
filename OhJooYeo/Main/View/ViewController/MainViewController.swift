//
//  ViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 4. 28..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
//    var worshipOrderList: [Model.WorshipOrder]?
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.rowHeight = UITableViewAutomaticDimension
//        self.worshipOrderList = WorshipCellData.shared.orderList
        
        NotificationCenter.default.addObserver(self, selector: #selector(worshipUpdate(_:)), name: .WorshipDidUpdated, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        makeDummyDatas()
//        makeDummyDatasForNextPresenter()
        
        self.listTableView.reloadData()
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orderList = WorshipCellData.shared.worshipOrderMO else {
            return 0
        }
        
        return orderList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orderList = WorshipCellData.shared.worshipOrderMO,
            let nextPresenter = WorshipCellData.shared.worshipMO?.nextPresenter,
            let nextOffer = WorshipCellData.shared.worshipMO?.nextOffer,
            let nextPrayer = WorshipCellData.shared.worshipMO?.nextPrayer else {
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
        guard let worshipOrderList = WorshipCellData.shared.worshipOrderMO else {
            return 50
        }
        if indexPath.row == worshipOrderList.count {
            return 128
        }
        
        return 50
    }
}

/// Custom Methods
extension MainViewController {
    @objc func worshipUpdate(_ notification: Notification) {
        OperationQueue.main.addOperation { [weak self] in
            self?.dateLabel.text = WorshipCellData.shared.dateInfo
            self?.listTableView.reloadData()
        }
    }
}

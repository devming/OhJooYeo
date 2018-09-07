//
//  ViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 4. 28..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var worshipOrderList: [Model.WorshipOrder]?
    var nextPresenter: Model.Worship.NextPresenter?
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.rowHeight = UITableViewAutomaticDimension
        self.worshipOrderList = WorshipCellData.shared.orderList
        self.nextPresenter = WorshipCellData.shared.nextPresenters
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
        guard let orderList = self.worshipOrderList else {
            return 0
        }
        
        return orderList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orderList = self.worshipOrderList, let nextPresenters = self.nextPresenter else {
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
            
            cell.mainPresenterLabel.text = nextPresenters.mainPresenter
            cell.prayerLabel.text = nextPresenters.prayer
            cell.offerLabel.text = nextPresenters.offer
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
}

extension MainViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let worshipOrderList = self.worshipOrderList else {
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
    
}

/// Dummy datas
extension MainViewController {
//    func makeDummyDatas() {
//        self.worshipOrderList?.orderList = [Model.WorshipOrder]()
//
////        orderList?.append(Model.WorshipElement(title: "경배와찬양", detail: "", presenter: "회중"))
////        orderList?.append(Model.WorshipElement(title: "기도", detail: "", presenter: "황대연"))
////        orderList?.append(Model.WorshipElement(title: "*성경봉독", detail: "요나서 2:7-10", presenter: "인도자"))
////        orderList?.append(Model.WorshipElement(title: "설교", detail: "감사의 노래", presenter: "김희선전도사"))
////        orderList?.append(Model.WorshipElement(title: "*헌금", detail: "", presenter: "표준범"))
////        orderList?.append(Model.WorshipElement(title: "*봉헌기도", detail: "", presenter: "설교자"))
////        orderList?.append(Model.WorshipElement(title: "성도의교제", detail: "", presenter: "인도자"))
////        orderList?.append(Model.WorshipElement(title: "*파송찬양", detail: "", presenter: "회중"))
////        orderList?.append(Model.WorshipElement(title: "*주기도문", detail: "", presenter: "회중"))
//    }
//    func makeDummyDatasForNextPresenter() {
//        self.worshipInfo?.nextPresenters = Model.Worship.NextPresenter(mainPresenter: "정민기", prayer: "강윤호", offer: "박재현")
//    }
}





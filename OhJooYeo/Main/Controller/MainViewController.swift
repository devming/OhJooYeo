//
//  ViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 4. 28..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var orderList: [Order]?
    var nextPresenters: NextPresenter?
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        makeDummyDatas()
        makeDummyDatasForNextPresenter()
        self.listTableView.reloadData()
    }

    

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let orderList = self.orderList else {
            return 0
        }
        
        return orderList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orderList = self.orderList, let nextPresenters = self.nextPresenters else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0..<orderList.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellName) as! OrderTableViewCell
            
            cell.titleLabel.text = orderList[indexPath.row].title
            cell.detailLabel.text = orderList[indexPath.row].detail
            cell.presenterLabel.text = orderList[indexPath.row].presenter
            
            return cell
            
        case orderList.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: NextPresenterTableViewCell.cellName) as! NextPresenterTableViewCell
            
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
        if indexPath.row == orderList?.count {
            return 128
        }
        
        return 50
    }
}

extension MainViewController {
    func makeDummyDatas() {
        orderList = [Order]()
        
        orderList?.append(Order(title: "경배와찬양", detail: "", presenter: "회중"))
        orderList?.append(Order(title: "기도", detail: "", presenter: "황대연"))
        orderList?.append(Order(title: "*성경봉독", detail: "요나서 2:7-10", presenter: "인도자"))
        orderList?.append(Order(title: "설교", detail: "감사의 노래", presenter: "김희선전도사"))
        orderList?.append(Order(title: "*헌금", detail: "", presenter: "표준범"))
        orderList?.append(Order(title: "*봉헌기도", detail: "", presenter: "설교자"))
        orderList?.append(Order(title: "성도의교제", detail: "", presenter: "인도자"))
        orderList?.append(Order(title: "*파송찬양", detail: "", presenter: "회중"))
        orderList?.append(Order(title: "*주기도문", detail: "", presenter: "회중"))
    }
    func makeDummyDatasForNextPresenter() {
        nextPresenters = NextPresenter(mainPresenter: "정민기", prayer: "강윤호", offer: "박재현")
    }
}





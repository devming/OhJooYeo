//
//  AdvertisementViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class AdvertisementViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    var advertisementList: [Model.Advertisement]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeDummyDatas()
    }
}

extension AdvertisementViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let advertisementList = self.advertisementList else {
            return 0
        }
        
        return advertisementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let advertisementList = self.advertisementList else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: AdvertisementTableViewCell.cellName) as! AdvertisementTableViewCell
        
        cell.titleLabel.text = advertisementList[indexPath.row].title
        cell.descriptionLabel.text = advertisementList[indexPath.row].description
        
        return cell
    }
    
    
}


extension AdvertisementViewController {
    func makeDummyDatas() {
        self.advertisementList = [Model.Advertisement]()
        
//        self.advertisementList?.append(Advertisement(title: "환영", description: "돈암동교회 청년예배에 처음 방문하신 여러분을 환영합니다"))
//        self.advertisementList?.append(Advertisement(title: "청년예배", description: "주일 오후 2시 입니다"))
//        self.advertisementList?.append(Advertisement(title: "기도 모임", description: "주일 오후 1시 30분(1330기도회)"))
//        self.advertisementList?.append(Advertisement(title: "대표기도 및 특송", description: "신청하고자 하시는 분은 임원에게 문의해 주십시오"))
//        self.advertisementList?.append(Advertisement(title: "기타", description: "오늘은 사순절 제3주 입니다"))
    }
}

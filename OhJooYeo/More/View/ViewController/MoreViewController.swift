//
//  MoreViewController.swift
//  OhJooYeo
//
//  Created by Minki on 02/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var moreTableView: UITableView!
    let moreMenuImageList = ["notice.png", "church.png", "map.png", "group.png", "version.png", "opensource.png", "donation.png", "document.png"]
    let moreMenuList = ["공지사항", "교회소개", "교회약도", "청년부소개", "버전 정보", "오픈소스 라이선스", "도네이션", "구글광고"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.moreTableView.dataSource = self
    }

}

extension MoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moreMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewCell.cellName) as? MoreTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = self.moreMenuList[indexPath.row]
        cell.menuImageView.image = UIImage(named: self.moreMenuImageList[indexPath.row])
        
        return cell
    }
    
    
}

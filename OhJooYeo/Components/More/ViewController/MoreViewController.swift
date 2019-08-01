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
    let moreMenuImageList = ["ic_notice.png", "ic_church.png", "ic_map.png", "ic_group.png", "ic_version.png", "ic_advertisement.png"]
//    let moreMenuImageList = ["ic_notice.png", "ic_church.png", "ic_map.png", "ic_group.png", "ic_version.png", "ic_opensource.png", "ic_donation.png", "ic_document.png"]
    let moreMenuList = ["공지사항", "교회소개", "교회약도", "청년부소개", "앱 정보", "구글광고"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTransparentBackground(navigationController: self.navigationController)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
//        if let cell = sender as? OrderTableViewCell, let indexPath = self.listTableView.indexPath(for: cell) {
//            guard let orderList = WorshipMainInfoViewModel.shared.worshipDataObject.worshipData?.worshipMainInfo?.worshipOrders, orderList[indexPath.row].type == WorshipOrder.TypeName.phrase.rawValue else {
//                return
//            }
//
//            if let destination = segue.destination as? PhraseDetailViewController {
//                destination.orderID = Int(orderList[indexPath.row].orderID)
//            }
//        }
        switch segue.identifier {
        case NoticeViewController.segueName:
            break
        case ChurchInfoViewController.segueName:
            break
        case LocationViewController.segueName:
            break
        case GroupInfoViewController.segueName:
            break
        case "appInfoSegue":
            break
        case "openSource":
            showConfirmationAlert(alertTitle: "준비중입니다.", alertMessage: "오픈소스라이선스", viewController: self)
        case "donation":
            showConfirmationAlert(alertTitle: "준비중입니다.", alertMessage: "도네이션", viewController: self)
        case "googleAd":
            showConfirmationAlert(alertTitle: "준비중입니다.", alertMessage: "구글광고", viewController: self)
        default:
            break
        }
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
//        let selectedView = UIView()
//        selectedView.backgroundColor = UIColor.red
//        cell.selectedBackgroundView = selectedView
        cell.titleLabel.text = self.moreMenuList[indexPath.row]
        cell.menuImageView.image = UIImage(named: self.moreMenuImageList[indexPath.row])
        
        return cell
    }
    
}

extension MoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var segueName = ""
        switch indexPath.row {
        case 0:
            segueName = NoticeViewController.segueName
        case 1:
            segueName = ChurchInfoViewController.segueName
        case 2:
            segueName = LocationViewController.segueName
        case 3:
            segueName = GroupInfoViewController.segueName
        case 4:
            segueName = "appInfoSegue"
        default:
            tableView.deselectRow(at: indexPath, animated: false)
            return
        }
        performSegue(withIdentifier: segueName, sender: tableView.cellForRow(at: indexPath))
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

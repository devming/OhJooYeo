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
    let moreMenuImageList = ["ic_notice.png", "ic_church.png", "ic_map.png", "ic_group.png", "ic_version.png", "ic_opensource.png", "ic_donation.png", "ic_document.png"]
//    let moreMenuImageList = ["ic_notice.png", "ic_church.png", "ic_map.png", "ic_group.png", "ic_version.png", "ic_opensource.png", "ic_donation.png", "ic_document.png"]
    let moreMenuList = ["공지사항", "교회소개", "교회약도", "청년부소개", "버전 정보", "오픈소스 라이선스", "도네이션", "구글광고"]
    
    var mapView: NMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientBackground()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier {
        case "notice":
            showConfirmationAlert(alertTitle: "준비중입니다.", alertMessage: "공지사항", viewController: self)
        case "churchInfo":
            showConfirmationAlert(alertTitle: "준비중입니다.", alertMessage: "교회소개", viewController: self)
        case "location":
            print("location")
        case "groupIntro":
            showConfirmationAlert(alertTitle: "준비중입니다.", alertMessage: "청년부소개", viewController: self)
        case "versionInfo":
            showConfirmationAlert(alertTitle: "준비중입니다.", alertMessage: "버전소개", viewController: self)
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
            segueName = "notice"
        case 1:
            segueName = "churchInfo"
        case 2:
            segueName = "location"
        case 3:
            segueName = "groupIntro"
        case 4:
            segueName = "versionInfo"
        case 5:
            segueName = "openSource"
        case 6:
            segueName = "donation"
        case 7:
            segueName = "googleAd"
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        performSegue(withIdentifier: segueName, sender: tableView.cellForRow(at: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        
        if let navigationController = self.navigationController {
            gradientLayer.frame = navigationController.navigationBar.frame
        }
        //        // Render the gradient to UIImage
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }
        gradientLayer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
    }
}

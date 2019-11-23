//
//  OrderTableViewCell.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class OrderRowCell: UITableViewCell {

    static let cellName = "OrderRowCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var presenterLabel: UILabel!
    @IBOutlet weak var accessoryImageView: UIImageView!
    @IBOutlet weak var standupMarkImageView: UIImageView!
    @IBOutlet weak var titleVerticalCenterConstraint: NSLayoutConstraint!
    
    func setItem(item: WorshipOrder) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
        presenterLabel.text = item.presenter
        standupMarkImageView.isHidden = !item.isStandUp
        
        if item.type == WorshipOrder.TypeName.phrase.rawValue {
            accessoryImageView.alpha = 1.0
            isUserInteractionEnabled = true
        } else {
            accessoryImageView.alpha = 0.0
            isUserInteractionEnabled = false
        }
        
        if item.detail?.isEmpty == true {
            titleVerticalCenterConstraint.constant = 0
        } else {
            titleVerticalCenterConstraint.constant = -10
        }
        layoutIfNeeded()
        
//        let bgColorView = UIView()
//        bgColorView.backgroundColor = UIColor.white
//        selectedBackgroundView = bgColorView
    }
}

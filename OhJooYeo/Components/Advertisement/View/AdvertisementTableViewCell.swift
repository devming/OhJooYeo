//
//  AdvertisementTableViewCell.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 2..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class AdvertisementTableViewCell: UITableViewCell {

    static let cellName = "cell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func setItem(item: Advertisement) {
        titleLabel.text = item.title
        contentLabel.text = item.content
    }
}

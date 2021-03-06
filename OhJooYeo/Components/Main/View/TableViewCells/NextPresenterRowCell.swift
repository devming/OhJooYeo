//
//  NextPresenterTableViewCell.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class NextPresenterRowCell: UITableViewCell {

    static let cellName = "NextPresenterRowCell"
    @IBOutlet weak var mainPresenterLabel: UILabel!
    @IBOutlet weak var prayerLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    
    func setItem(item: NextPresenter) {
        mainPresenterLabel.text = item.mainPresenter
        prayerLabel.text = item.prayer
        offerLabel.text = item.offer
    }
}

//
//  YearlyPhraseRowCell.swift
//  OhJooYeo
//
//  Created by Minki on 2019/11/02.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class YearlyPhraseRowCell: UITableViewCell {
    static let cellName = "YearlyPhraseRowCell"
    
    @IBOutlet weak var yearlyPhraseLabel: UILabel!
    
    func setItem(message: String) {
        self.yearlyPhraseLabel.text = message
    }
}

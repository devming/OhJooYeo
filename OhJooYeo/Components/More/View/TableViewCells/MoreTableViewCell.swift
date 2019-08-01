//
//  MoreCollectionViewCell.swift
//  OhJooYeo
//
//  Created by Minki on 02/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    static let cellName = "moreCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuImageView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.backgroundColor = UIColor.white
        self.alpha = 0.5
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1.0
        }
    }
}

//
//  MusicCollectionViewCell.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    static let cellName = "scoreCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scoreImageView: UIImageView!
    @IBOutlet weak var lylicsTextView: UITextView!
}

//
//  UICardView.swift
//  OhJooYeo
//
//  Created by Minki on 10/03/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 1
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor.gray
    @IBInspectable var shadowOpacity: Float = 1
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
    }
    
}

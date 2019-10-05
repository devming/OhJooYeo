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
        
//        let colorArea = UIView(frame: CGRect(x: 0, y: 0, width: 5.0, height: self.frame.height))
//        colorArea.backgroundColor = UIColor.blue
//        addSubview(colorArea)
        
//        layer.borderWidth = 2.0
//        layer.borderColor = UIColor.black.cgColor
//        layer.cornerRadius = cornerRadius
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
    }
    
}

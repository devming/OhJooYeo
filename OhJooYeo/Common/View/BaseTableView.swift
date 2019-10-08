//
//  BaseTableView.swift
//  OhJooYeo
//
//  Created by Minki on 29/09/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    func setupView() {

        let cornerRadius: CGFloat = 10
        let shadowOffsetWidth: Int = 1
        let shadowOffsetHeight: Int = 1
        let shadowColor: UIColor = UIColor.gray
        let shadowOpacity: Float = 1
        
        layer.cornerRadius = cornerRadius
        
//        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
    }
}

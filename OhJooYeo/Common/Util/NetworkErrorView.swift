//
//  NetworkErrorView.swift
//  OhJooYeo
//
//  Created by Minki on 18/08/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class NetworkErrorView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        let imageView = UIImageView(frame: self.frame)
        imageView.image = UIImage(named: "ic_network_error")
        imageView.contentMode = .center
        addSubview(imageView)
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
}

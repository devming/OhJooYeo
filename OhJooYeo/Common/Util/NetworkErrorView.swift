//
//  NetworkErrorView.swift
//  OhJooYeo
//
//  Created by Minki on 18/08/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit
import SnapKit

class NetworkErrorView: UIButton {

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
        imageView.snp.remakeConstraints { maker in
            maker.top.bottom.leading.trailing.equalTo(self)
        }
    }
}

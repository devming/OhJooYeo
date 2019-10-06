//
//  MainTabBar.swift
//  OhJooYeo
//
//  Created by Minki on 06/10/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class MainTabBar: UITabBar {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    func setup() {
    }

}

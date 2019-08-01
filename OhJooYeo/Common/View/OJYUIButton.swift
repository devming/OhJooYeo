//
//  OJYUIButton.swift
//  OhJooYeo
//
//  Created by Minki on 18/05/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class OJYUIButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }
    
    func initializeUI() {
        self.setBackgroundColor(red: 20.0, green: 95.0, blue: 207.0, alpha: 1.0)
        self.layer.cornerRadius = 5.0
    }
    
    func setBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.backgroundColor = UIColor(displayP3Red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    func setForegroundColorByState(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat, state: UIControl.State) {
        self.setTitleColor(UIColor(displayP3Red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha), for: state)
    }
}

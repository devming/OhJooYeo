//
//  OJYTextField.swift
//  OhJooYeo
//
//  Created by Minki on 02/05/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

@IBDesignable
class OJYUITextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }
    
    func initializeUI() {
        self.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.2)
        self.layer.borderColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 30.0
    }
}

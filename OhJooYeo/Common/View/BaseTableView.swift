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
        
    }
    
}

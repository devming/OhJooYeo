//
//  NextPresenterSectionHeader.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/13.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class NextPresenterSectionHeader: UITableViewHeaderFooterView {

    static let headerName = "NextPresenterSectionHeader"
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    func setup() {
        if let view = Bundle.main.loadNibNamed(NextPresenterSectionHeader.headerName, owner: self, options: nil)?.first as? NextPresenterSectionHeader {
            addSubview(view)
        }
    }
}

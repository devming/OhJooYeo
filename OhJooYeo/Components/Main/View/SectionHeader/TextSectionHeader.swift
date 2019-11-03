//
//  NextPresenterSectionHeader.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/13.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class TextSectionHeader: UITableViewHeaderFooterView {

    static let headerName = "TextSectionHeader"
    @IBOutlet weak var titleLabel: UILabel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    func setup() {
        if let view = Bundle.main.loadNibNamed(TextSectionHeader.headerName, owner: self, options: nil)?.first as? TextSectionHeader {
            addSubview(view)
        }
    }
    
    func setTitle(text: String) {
        self.titleLabel?.text = text
    }
}

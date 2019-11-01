//
//  FirstSectionHeader.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/13.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class FirstSectionHeader: UITableViewHeaderFooterView {
    
    static let headerName = "FirstSectionHeader"

    @IBOutlet weak var mainPresenterLabel: UILabel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
    }

    func setup() {
        if let view = Bundle.main.loadNibNamed(FirstSectionHeader.headerName, owner: self, options: nil)?.first as? FirstSectionHeader {
            self.addSubview(view)
        }
    }
    
    func setMainPresenter(mainPresenter: String?) {
        self.mainPresenterLabel?.text = "인도자: \(mainPresenter)"
    }
}

//
//  FirstSectionHeader.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/13.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class FirstSectionHeader: UIView {

    @IBOutlet weak var mainPresenterLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        if let view = Bundle.main.loadNibNamed("FirstSectionHeader", owner: self, options: nil)?.first as? FirstSectionHeader {
            self.addSubview(view)
        }
    }
    
    func setMainPresenter(mainPresenter: String?) {
        mainPresenterLabel.text = mainPresenter
    }
}

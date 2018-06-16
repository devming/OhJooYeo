//
//  NextPresenter.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NextPresenter {
    var mainPresenter: String?
    var prayer: String?
    var offer: String?
    
    init?(mainPresenter: String?, prayer: String?, offer: String?) {
        guard let mainPresenter = mainPresenter, let prayer = prayer, let offer = offer else {
            return nil
        }
        self.mainPresenter = mainPresenter
        self.prayer = prayer
        self.offer = offer
    }
}

//
//  NextPresenter.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift

class NextPresenter: Decodable {
    var mainPresenter: String = ""
    var prayer: String = ""
    var offer: String = ""
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mainPresenter = try container.decode(String.self, forKey: .mainPresenter)
        self.prayer = try container.decode(String.self, forKey: .prayer)
        self.offer = try container.decode(String.self, forKey: .offer)
    }
    
    enum CodingKeys: String, CodingKey {
        case mainPresenter = "mainPresenter"
        case prayer = "prayer"
        case offer = "offer"
    }
}

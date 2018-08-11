//
//  Advertisement.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 2..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Model {
    struct Advertisement {
        var title: String
        var description: String
        var order: Int
        
        init(title: String, description: String, order: Int) {
            self.title = title
            self.description = description
            self.order = order
        }
        
        init?(json: JSON) {
            guard let title = json["title"].string else {
                return nil
            }
            self.title = title
            
            guard let description = json["description"].string else {
                return nil
            }
            self.description = description
            
            guard let order = json["order"].int else {
                return nil
            }
            self.order = order
        }
    }
}

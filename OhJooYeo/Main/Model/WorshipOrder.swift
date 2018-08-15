//
//  Order.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Model {
    struct WorshipOrder {
        var title: String
        var detail: String
        var presenter: String
        var order: Int
        
        init(title: String, detail: String, presenter: String, order: Int) {
            self.title = title
            self.detail = detail
            self.presenter = presenter
            self.order = order
        }
        
        init?(json: JSON) {
            guard let title = json["title"].string else {
                return nil
            }
            self.title = title
            
            if let detail = json["detail"].string {
                self.detail = detail
            } else {
                self.detail = ""
            }
            
            guard let presenter = json["presenter"].string else {
                return nil
            }
            self.presenter = presenter
            
            guard let order = json["order"].int else {
                return nil
            }
            self.order = order
        }
    }
}

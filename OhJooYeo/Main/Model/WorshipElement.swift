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
    struct WorshipElement {
        var title: String
        var detail: String
        var presenter: String
        
        init(title: String, detail: String, presenter: String) {
            self.title = title
            self.detail = detail
            self.presenter = presenter
        }
        
        init?(json: JSON) {
            guard let title = json["title"].string else {
                return nil
            }
            self.title = title
            
            guard let detail = json["detail"].string else {
                return nil
            }
            self.detail = detail
            
            guard let presenter = json["presenter"].string else {
                return nil
            }
            self.presenter = presenter
        }
    }
}

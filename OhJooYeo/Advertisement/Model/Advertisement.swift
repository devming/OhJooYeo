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
        var content: String
        var order: Int
        
        init(title: String, content: String, order: Int) {
            self.title = title
            self.content = content
            self.order = order
        }
        
        init?(json: JSON) {
            if let title = json[Name.title].string {
                self.title = title
            } else {
                self.title = "기타"
            }
            
            guard let content = json[Name.content].string else {
                return nil
            }
            self.content = content
            
            guard let order = json[Name.order].int else {
                return nil
            }
            self.order = order
        }
    }
}

extension Model.Advertisement {
    struct Name {
        static let title = "title"
        static let content = "content"
        static let order = "order"
    }
}

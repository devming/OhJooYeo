//
//  Advertisement.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 2..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Advertisement {
    var title: String?
    var description: String?
    
    init(title: String?, description: String?) {
        self.title = title
        self.description = description
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
    }
}

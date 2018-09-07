//
//  WorshipIdList.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 1..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Model {
    struct Constant {
        static let emptyString = ""
    }
}
extension Model {
    struct WorshipIdDate {
        var date: String
        var worshipId: String
        
        init?(json: JSON) {
//            if let datas = json.array {
//                datas.map { (data) -> T in
//                    <#code#>
//                }
                if let date = json[Name.date].string {
                    self.date = date
                } else {
                    self.date = Model.Constant.emptyString
                }
                
                if let worshipId = json[Name.worshipId].string {
                    self.worshipId = worshipId
                } else {
                    self.worshipId = Model.Constant.emptyString
                }
//            }
        }
    }
}

extension Model.WorshipIdDate {
    struct Name {
        static let date = "worshipDate"
        static let worshipId = "worshipId"
    }
}


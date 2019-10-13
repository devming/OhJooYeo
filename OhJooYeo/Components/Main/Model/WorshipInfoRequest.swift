//
//  WorshipInfoRequest.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/12.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation

class WorshipInfoRequest: BaseRequest {
    var worshipId: String?
    var version: Int = 0
    
    init(churchId: Int, worshipId: String, version: Int = 0) {
        super.init()
        self.churchId = churchId
        self.worshipId = worshipId
        self.version = version
    }
    
    enum CodingKeys: String, CodingKey {
        case churchId = "churchId"
        case worshipId = "worshipId"
        case version = "version"
    }
}

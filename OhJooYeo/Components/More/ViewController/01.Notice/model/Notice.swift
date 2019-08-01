//
//  Notice.swift
//  OhJooYeo
//
//  Created by Minki on 13/06/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation

struct Notice: Codable, NoticeModelItem {
    var isCollapsed: Bool = true    
    var date: Date
    var title: String
    var content: String
}

extension NoticeModelItem {
    var rowCount: Int {
        return 1
    }
    var isCollapsible: Bool {
        return true
    }
    
}

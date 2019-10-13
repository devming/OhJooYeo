//
//  Notice.swift
//  OhJooYeo
//
//  Created by Minki on 13/06/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation

class Notice: Decodable, NoticeModelItem {
    
    var isCollapsed: Bool = true
    var noticeId: Int?
    var date: String?
    var title: String?
    var content: String?
    var writer: String?
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.noticeId = try container.decode(Int.self, forKey: .noticeId)
        self.date = try container.decode(String.self, forKey: .date)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.writer = try container.decode(String.self, forKey: .writer)
    }
    
    enum CodingKeys: String, CodingKey {
        case noticeId = "noticeId"
        case title = "title"
        case content = "content"
        case date = "regDate"
        case writer = "userId"
        case order = "order"
    }
}

extension NoticeModelItem {
    var rowCount: Int {
        return 1
    }
    var isCollapsible: Bool {
        return true
    }
    
}

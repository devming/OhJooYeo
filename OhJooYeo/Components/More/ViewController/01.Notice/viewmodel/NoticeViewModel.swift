//
//  NoticeViewModel.swift
//  OhJooYeo
//
//  Created by Minki on 14/07/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation

class NoticeViewModel: NSObject {
    var items: [Notice]
    var reloadSections: ((_ section: Int) -> Void)?
    var numberOfDatas: Int {
        get {
            return items.count
        }
    }
    
    override init() {
        items = [Notice]()
    }
    
    func setTestData() {
        let data: [Notice] = [
            Notice(isCollapsed: true, date: Date.init(timeIntervalSinceNow: TimeInterval()), title: "테스트 공지1", content: "테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용1"),
            Notice(isCollapsed: true, date: Date.init(timeIntervalSinceNow: TimeInterval()), title: "테스트 공지2", content: "테스트 내용2"),
            Notice(isCollapsed: true, date: Date.init(timeIntervalSinceNow: TimeInterval()), title: "테스트 공지3", content: "테스트 내용3"),
            Notice(isCollapsed: true, date: Date.init(timeIntervalSinceNow: TimeInterval()), title: "테스트 공지4", content: "테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용4"),
            Notice(isCollapsed: true, date: Date.init(timeIntervalSinceNow: TimeInterval()), title: "테스트 공지5", content: "테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용테스트 내용5"),
            Notice(isCollapsed: true, date: Date.init(timeIntervalSinceNow: TimeInterval()), title: "테스트 공지6", content: "테스트 내용6")
                              ]
        items = data
    }
}

extension NoticeViewModel: HeaderViewDelegate {
    func toggleSection(header: NoticeHeaderView, section: Int) {
        var item = items[section]
        if item.isCollapsible {
            print("#### \(item.isCollapsed)")
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
//            header.setCollapsed(collapsed: collapsed)
            
            items[section].isCollapsed = collapsed
            
            reloadSections?(section)
        }
        
    }
}


//
//  NoticeModelItem.swift
//  OhJooYeo
//
//  Created by Minki on 17/07/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation

protocol NoticeModelItem {
    var rowCount: Int { get }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

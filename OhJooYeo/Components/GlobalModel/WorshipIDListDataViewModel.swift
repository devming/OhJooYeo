//
//  WorshipIdListData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 7..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class WorshipIDListDataViewModel {
    
    static var shared = WorshipIDListDataViewModel()
    var worshipIdDate: [WorshipIDDate]?
    
    private init() {}
    
}

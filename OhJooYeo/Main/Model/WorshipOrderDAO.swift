//
//  WorshipOrder+DataManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 15..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

import Foundation
import CoreData

extension DbManager {
    func addWorshipOrder(worshipOrders: [Model.WorshipOrder]) {
        if let newPhrase = self.worshipOrderMO {      // type casting을 해서 내가 사용할 엔티티를 가져와야한다.
            for worshipOrder in worshipOrders {
                newPhrase.title = worshipOrder.title
                newPhrase.detail = worshipOrder.detail
                newPhrase.presenter = worshipOrder.presenter
                newPhrase.order = Int32(worshipOrder.order)
                saveContext()
            }
        }
    }
    
    func getWorshipOrderList() -> [WorshipOrderMO] {
        // 1. NSFetchRequest
        let request = NSFetchRequest<WorshipOrderMO>(entityName: DbManager.EntityName.worshipOrderEntityName)
        
        // 2. sorting
        let sortByOrderDesc = NSSortDescriptor(key: ColumnKey.WorshipOrder.order, ascending: true)
        request.sortDescriptors = [sortByOrderDesc]
        
        if let result = try? defaultContext.fetch(request) {
            return result
        }
        return [WorshipOrderMO]()
    }
}

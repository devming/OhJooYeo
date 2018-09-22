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
    func addWorshipOrder(worshipOrders: [Model.WorshipOrder], worshipMO: WorshipMO) {
        for worshipOrder in worshipOrders {
            if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.worshipOrderEntityName, into: defaultContext) as? WorshipOrderMO {
                newPhrase.title = worshipOrder.title
                newPhrase.detail = worshipOrder.detail
                newPhrase.presenter = worshipOrder.presenter
                newPhrase.order = Int32(worshipOrder.order)
                worshipMO.addToWorshipOrders(newPhrase)
                saveContext()
            }
        }
    }
    
    func updateWorshipOrder(worshipOrders: [Model.WorshipOrder], worshipMO: WorshipMO) {
        if let worshipOrderMO = worshipMO.worshipOrders {
            for worshipOrderItem in worshipOrderMO {
                guard let item = worshipOrderItem as? WorshipOrderMO else {
                    continue
                }
                delete(item)
            }
            saveContext()
        }
        for worshipOrder in worshipOrders {
            if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.worshipOrderEntityName, into: defaultContext) as? WorshipOrderMO {
                newPhrase.title = worshipOrder.title
                newPhrase.detail = worshipOrder.detail
                newPhrase.presenter = worshipOrder.presenter
                newPhrase.order = Int32(worshipOrder.order)
                worshipMO.addToWorshipOrders(newPhrase)
                saveContext()
            }
        }
    }
    
    func getWorshipOrderList(worshipMO: WorshipMO?) -> [WorshipOrderMO] {
        
        // 1. NSFetchRequest
        let request: NSFetchRequest<WorshipOrderMO> = WorshipOrderMO.fetchRequest()
        
        // 2. sorting
        let sortByOrderDesc = NSSortDescriptor(key: ColumnKey.WorshipOrder.order, ascending: true)
        request.sortDescriptors = [sortByOrderDesc]
        
        if let worshipMO = worshipMO {
            let predict = NSPredicate(format: "worship == %@", worshipMO)
            request.predicate = predict
        }
        
        if let result = try? defaultContext.fetch(request) {
            return result
        }
        return [WorshipOrderMO]()
    }
}

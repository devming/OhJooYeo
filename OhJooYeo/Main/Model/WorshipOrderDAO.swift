//
//  WorshipOrder+DataManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 15..
//  Copyright © 2018년 devming. All rights reserved.
//

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
                newPhrase.orderId = Int32(worshipOrder.orderId)
                newPhrase.type = Int32(worshipOrder.type)
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
                newPhrase.orderId = Int32(worshipOrder.orderId)
                newPhrase.type = Int32(worshipOrder.type)
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
    
    /**
     성경말씀 shortcut 이름 찾는 부분
     ex) 여호수아 1:5
     */
    func getPhraseMessageShortCutWithOrderId() {
        guard let orderList = WorshipCellData.shared.worshipOrderMO else {
            return
        }
        for order in orderList {
            if let detail = order.detail, order.type == Model.WorshipOrder.TypeName.phrase.rawValue {
                print("detail:\(detail)")
                App.api.getPhraseMessages(shortCut: detail, phraseMessageOrderId: order.orderId) { }
            }
        }
    }
}

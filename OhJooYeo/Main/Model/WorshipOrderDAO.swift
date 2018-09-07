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
        if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: DbManager.Name.worshipOrderEntityName, into: defaultContext) as? WorshipOrderMO {      // type casting을 해서 내가 사용할 엔티티를 가져와야한다.
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
        let request = NSFetchRequest<WorshipOrderMO>(entityName: DbManager.Name.worshipOrderEntityName)
        
        // 2. sorting
        let sortByDateDesc = NSSortDescriptor(key: "insertAt", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        /// Pattern1-예외처리 안하는 방식 - 발생하는 예외를 처리하지 않고 그냥 넘어감.
        if let result = try? defaultContext.fetch(request) {
            return result
        }
        return [WorshipOrderMO]()
        
        /// Pattern2-예외처리 하는 방식
//        do {
//            // 3. context
//            let result = try defaultContext.fetch(request)
//            return result
//        } catch {
//            print(error)
//        }
//        return [MemoEntity]()
    }
}

//
//  Worship+DataManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import CoreData

extension DbManager {
    
    struct KeyName {
        static let mainPresenter = "mainPresenter"
        static let nextOffer = "nextOffer"
        static let nextPrayer = "nextPrayer"
        static let nextPresenter = "nextPresenter"
        static let version = "version"
        static let worshipDate = "worshipDate"
        static let worshipId = "worshipId"
    }
    
    func addWorship(mainPresenter: String?, worshipOrder: [Model.WorshipOrder]?, nextPresenter: Model.Worship.NextPresenter?) {
        if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: DbManager.Name.worshipEntityName, into: defaultContext) as? WorshipMO
        {      // type casting을 해서 내가 사용할 엔티티를 가져와야한다.
            
            if let mainPresenter = mainPresenter {
                newPhrase.mainPresenter = mainPresenter
            }
            if let nextPresenter = nextPresenter {
                newPhrase.nextPresenter = nextPresenter.mainPresenter
                newPhrase.nextOffer = nextPresenter.offer
                newPhrase.nextPrayer = nextPresenter.prayer
            }
            if let worshipOrderValue = worshipOrder {
                addWorshipOrder(worshipOrders: worshipOrderValue)
            }
            
            saveContext()
        }
    }
    
    func getWorshipList() -> [WorshipMO] {
        // 1. NSFetchRequest
        let request = NSFetchRequest<WorshipMO>(entityName: DbManager.Name.worshipEntityName)
        
        // 2. sorting
        let sortByDateDesc = NSSortDescriptor(key: KeyName.worshipDate, ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        /// Pattern1-예외처리 안하는 방식 - 발생하는 예외를 처리하지 않고 그냥 넘어감.
        if let result = try? self.defaultContext.fetch(request) {
            return result
        }
        return [WorshipMO]()
        
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

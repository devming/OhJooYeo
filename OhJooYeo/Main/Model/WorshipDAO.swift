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
    func addWorship(mainPresenter: String?, worshipOrder: [Model.WorshipOrder]?, nextPresenter: Model.Worship.NextPresenter?, version: String, worshipDate: String, worshipId: String) {
        if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.worshipEntityName, into: defaultContext) as? WorshipMO {
              // type casting을 해서 내가 사용할 엔티티를 가져와야한다.
            if let mainPresenter = mainPresenter {
                newPhrase.mainPresenter = mainPresenter
            }
            if let nextPresenter = nextPresenter {
                newPhrase.nextPresenter = nextPresenter.mainPresenter
                newPhrase.nextOffer = nextPresenter.offer
                newPhrase.nextPrayer = nextPresenter.prayer
            }
            newPhrase.version = version
            newPhrase.worshipDate = worshipDate
            newPhrase.worshipId = worshipId
            if let worshipOrderValue = worshipOrder {
                addWorshipOrder(worshipOrders: worshipOrderValue, worshipMO: newPhrase)
//                let worshipOrderMOList = getWorshipOrderList()
//                newPhrase.addToWorshipOrders(worshipOrderMO)
            }
            
            saveContext()
        }
    }
    
    func getRecentWorship(/*id or date 필터링 조건 넣어야할듯*/) -> WorshipMO {
        if let result = getWorshipList().first {
            return result
        }
        return WorshipMO()
    }
    
    func getWorshipList() -> [WorshipMO] {
        // 1. NSFetchRequest
        let request = NSFetchRequest<WorshipMO>(entityName: DbManager.EntityName.worshipEntityName)
        
        // 2. sorting - 내림차순이어야 가장 위에 최신 것을 받을 수 있음
        let sortByDateDesc = NSSortDescriptor(key: ColumnKey.Worship.worshipDate, ascending: false)
        let sortByVersionDesc = NSSortDescriptor(key: ColumnKey.Worship.version, ascending: false)
        request.sortDescriptors = [sortByDateDesc, sortByVersionDesc]
        
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

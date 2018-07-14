//
//  PhraseMessage+DataManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import CoreData

extension DbManager {
    func addWorship(with mainPresenter: String, worshipOrder: [Model.WorshipElement], nextPresenter: [Model.Worship.NextPresenter]) {
        if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: "Worship", into: defaultContext) as? WorshipEntity {      // type casting을 해서 내가 사용할 엔티티를 가져와야한다.
            newPhrase.mainPresenter = mainPresenter
            
            saveContext()
        }
    }
    
    
    func getWorshipList() -> [WorshipEntity] {
        // 1. NSFetchRequest
        let request = NSFetchRequest<WorshipEntity>(entityName: "Worship")
        
        // 2. sorting
        let sortByDateDesc = NSSortDescriptor(key: "insertAt", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        /// Pattern1-예외처리 안하는 방식 - 발생하는 예외를 처리하지 않고 그냥 넘어감.
        if let result = try? defaultContext.fetch(request) {
            return result
        }
        return [WorshipEntity]()
        
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
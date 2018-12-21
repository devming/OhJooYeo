//
//  AdvertisementDAO.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import CoreData

extension DbManager {
    func addAdvertisement(advertisements: [Model.Advertisement]?, worshipMO: WorshipMO?) {
        guard let advertisements = advertisements, let worshipMO = worshipMO else {
            return
        }
        saveAdvertisementToContext(advertisements, worshipMO: worshipMO)
    }
    
    func updateAdvertisement(advertisements: [Model.Advertisement]?, worshipMO: WorshipMO?) {
        guard let advertisements = advertisements, let worshipMO = worshipMO else {
            return
        }
        if let advertisements = worshipMO.advertisements {
            for advertisement in advertisements {
                guard let item = advertisement as? AdvertisementMO else {
                    continue
                }
                delete(item)
            }
            saveContext()
        }
        saveAdvertisementToContext(advertisements, worshipMO: worshipMO)
    }
    
    // 검색 조건, worshipId에 맞는 녀석들만 불러온다.
    func getAdvertisementList(worshipId: String?) -> [AdvertisementMO] {
        // 1. NSFetchRequest
        let request = NSFetchRequest<AdvertisementMO>(entityName: DbManager.EntityName.advertisementEntityName)
        
        if let worshipId = worshipId {
            let predicate = NSPredicate(format: "%K == %@", #keyPath(WorshipMO.worshipId), worshipId)
            request.predicate = predicate
        }
        if let result = try? defaultContext.fetch(request) {
            return result
        }
        return [AdvertisementMO]()
    }
    
    private func saveAdvertisementToContext(_ advertisements: [Model.Advertisement], worshipMO: WorshipMO) {
        for advertisement in advertisements {
            if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.advertisementEntityName, into: defaultContext) as? AdvertisementMO {
                newPhrase.title = advertisement.title
                newPhrase.content = advertisement.content
                newPhrase.order = Int32(advertisement.order)
                newPhrase.worshipId = worshipMO.worshipId
                worshipMO.addToAdvertisements(newPhrase)
                saveContext()
            }
        }
    }
}

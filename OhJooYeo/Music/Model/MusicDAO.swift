//
//  MusicDAO.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import CoreData

extension DbManager {
    func addMusic(musics: [Music]?, worshipMO: WorshipMO?) {
//        guard let musics = musics, let worshipMO = worshipMO else {
//            return
//        }
//        saveMusicToContext(musics, worshipMO: worshipMO)
    }
    
    func updateMusic(musics: [Music]?, worshipMO: WorshipMO?) {
//        guard let musics = musics, let worshipMO = worshipMO else {
//            return
//        }
//        if let musics = worshipMO.musics {
//            for music in musics {
//                guard let item = music as? MusicMO else {
//                    continue
//                }
//                delete(item)
//            }
//            saveContext()
//        }
//        saveMusicToContext(musics, worshipMO: worshipMO)
    }
    
    // 검색 조건, worshipId에 맞는 녀석들만 불러온다.
    func getMusicList(worshipId: String?) -> [MusicMO] {
//        // 1. NSFetchRequest
//        let request = NSFetchRequest<MusicMO>(entityName: DbManager.EntityName.musicEntityName)
//
//        if let worshipId = worshipId {
//            let predicate = NSPredicate(format: "%K == %@", #keyPath(WorshipMO.worshipId), worshipId)
//            request.predicate = predicate
//        }
//        if let result = try? defaultContext.fetch(request) {
//            return result
//        }
        return [MusicMO]()
    }
    
    private func saveMusicToContext(_ musics: [Music], worshipMO: WorshipMO) {
//        for music in musics {
//            if let newPhrase = NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.musicEntityName, into: defaultContext) as? MusicMO {
//                newPhrase.title = music.title
//                newPhrase.imageName = music.imageName
//                newPhrase.order = Int32(music.order)
////                newPhrase.lylics = music.lylics
////                newPhrase.order = Int32(advertisement.order)
//                newPhrase.worshipId = worshipMO.worshipId
//                worshipMO.addToMusics(newPhrase)
//                saveContext()
//            }
//        }
    }
}

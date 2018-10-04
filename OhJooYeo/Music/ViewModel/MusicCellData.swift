//
//  MusicCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

final class MusicCellData {
    static var shared = MusicCellData()
    var musics: [MusicMO]?
    
    func setMusic(musicModels: [Model.Music]?) {
        guard let worshipMO = WorshipCellData.shared.worshipMO,
            let worshipVersion = worshipMO.version,
            let musicModels = musicModels else {
                return
        }
        
        let remoteWorshipVersion = worshipVersion[worshipVersion.index(worshipVersion.startIndex, offsetBy: 2)]
        
        let currentLocalVersion = GlobalState.shared.version
        let currentLocalWorshipVersion = currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 2)]
        //        remoteWorshipVersion = "d"
        if currentLocalWorshipVersion == ConstantString.notSetVersion { // 현재 로컬 버전이 최초 아무것도 없는 경우(*인경우) - Add
            DbManager.shared.addMusic(musics: musicModels, worshipMO: worshipMO)
        } else if currentLocalWorshipVersion < remoteWorshipVersion { // 받아온 정보가 더 최신일 경우 - Update
            DbManager.shared.updateMusic(musics: musicModels, worshipMO: worshipMO)
        }
        
        if let version = worshipMO.version {
            let musicVersion = version[version.index(version.startIndex, offsetBy: 2)]
            
            GlobalState.shared.version = "\(currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 0)])" + "\(currentLocalVersion[currentLocalVersion.index(currentLocalVersion.startIndex, offsetBy: 1)])" + "\(musicVersion)"
        }
        
        self.musics = DbManager.shared.getMusicList(worshipId: worshipMO.worshipId)
        
        NotificationCenter.default.post(name: .MusicDidUpdated, object: nil)
    }
}

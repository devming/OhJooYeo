//
//  MusicCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation

final class MusicViewModel {
    static var shared = MusicViewModel()
    var musics: [MusicMO]?
    
    func setMusic(worshipMO: WorshipMO?) {
        guard let worshipMO = worshipMO else {
                return
        }
        
        self.musics = DbManager.shared.getMusicList(worshipId: worshipMO.worshipId)
    }
}

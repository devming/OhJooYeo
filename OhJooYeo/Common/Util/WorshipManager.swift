//
//  WorshipManager.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/09.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation

class WorshipManager {
    static let shared = WorshipManager()
    
    /// worship-list API호출하고나서 바로 할당해 줘야함.
    var worshipIdDateList: [WorshipIdDate]?
    
    var currentIndex = 0
    
    /// - TODO:[] worshipIdDateList[currentIndex]에 데이터를 넣어주도록 바꿔야함
    
    var currentDate: String {
        get {
            guard let date = self.worshipIdDateList?[currentIndex].date else {
                return GlobalState.Constants.none.rawValue
            }
            return date
        }
    }
    var currentWorshipId: String {
           get {
               guard let worshipId = self.worshipIdDateList?[currentIndex].worshipId else {
                   return GlobalState.Constants.none.rawValue
               }
               return worshipId
           }
       }
    var currentVersion: Int {
        get {
            guard let version = self.worshipIdDateList?[currentIndex].version else {
                return 0
            }
            return version
        }
    }
    var churchId = 1 /// - TODO: [2019-11-22] 원래 0으로 해놓고 0이면 에러나게 해야함 - 로그인하면 churchId 설정하게 할것!
    
    /// currentWorshipId를 할당해주는 메소드 - 'worship-list' API에서 호출해야함.
//    func setRecentWorshipId(worshipIdList: [WorshipIdDate]) {
//        if worshipIdList.count == 0 { return }
//        var list = worshipIdList
//        list.sort { $0.worshipId > $1.worshipId } /// 날짜 내림차순 정렬
//        if let item = list.first { /// 가장 처음이니까 최신 날짜 주보
//            self.currentWorshipId = item.worshipId
//            self.currentDate = item.date
//        }
//    }
    func setRecentWorshipId(worshipIdList: [WorshipIdDate]) {
        if worshipIdList.count == 0 { return }
        self.worshipIdDateList = worshipIdList
        self.worshipIdDateList?.sort { $0.worshipId > $1.worshipId } /// 날짜 내림차순 정렬
        
        self.currentIndex = 0
    }
    
    func setWorshipListData(index: Int, worshipIdDate: WorshipIdDate) {
        self.currentIndex = index
        self.worshipIdDateList?[index] = worshipIdDate
    }
}

////
////  RealmHelper.swift
////  OhJooYeo
////
////  Created by Minki on 03/08/2019.
////  Copyright © 2019 devming. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
//class RealmHelper: BaseRealm {
//
//    static func insertReadNews(news:News) {
//        if news.id == nil {
//            return
//        }
//
//        if self.isReadNews(news: news) {
//            if let readNews = getReadNews(newsId: news.id!) {
//                readNews.updateReadTime()
//                insertReadNews(readNews: readNews)
//            }
//        } else {
//            insertReadNews(readNews: ReadNews().fromNews(news: news))
//        }
//
//    }
//
//    static func insertReadNews(readNews:ReadNews) {
//        _ = insertRow(row: readNews, update: true)
//
//        let userConfig = getUserConfig()
//        if userConfig?.myNewsCardState != CardState.done.rawValue {
//            let readNewsCount = getReadCountOnlyNews()
//            guard let config = userConfig else {
//                return
//            }
//
//            if readNewsCount == 0 {
//                config.myNewsCardState = CardState.analysisStart.rawValue
//
//            } else if readNewsCount > 0, readNewsCount < 10 {
//                config.myNewsCardState = CardState.analysisProgress.rawValue
//
//            } else if readNewsCount == 10 {
//                config.myNewsCardState = CardState.analysisComplete.rawValue
//
//            }
//
//            insertUserConfig(config: config)
//        }
//    }
//
//    static func isReadNews(news:News) -> Bool {
//        guard let newsId = news.id else {
//            return false
//        }
//        return isExsist(type: ReadNews.self, key: "newsId", value: newsId)
//    }
//
//    static func getReadNews(newsId:String) -> ReadNews? {
//        if !UserHelper.share.isCheckIn {
//            return nil
//        }
//
//        let realm = try! Realm()
//        if let row = getRow(realm: realm, type: ReadNews.self, key: "newsId", value: newsId) {
//            return ReadNews(value: row)
//
//        } else {
//            return nil
//        }
//    }
//
//    static func getReadNewses() -> [ReadNews]? {
//        if !UserHelper.share.isCheckIn {
//            return nil
//        }
//
//        var readNewses = [ReadNews]()
//
//        let realm = try! Realm()
//        let row = getAllRows(realm: realm, type: ReadNews.self)
//        for readnews in row {
//            readNewses.append(readnews)
//        }
//        return readNewses
//    }
//
//    static func getReadNewses(ascending:Bool, page:Int, count:Int) -> [ReadNews]? {
//        if !UserHelper.share.isCheckIn {
//            return nil
//        }
//
//        var readNewses = [ReadNews]()
//
//        let realm = try! Realm()
//        let row = getAllRows(realm: realm, type: ReadNews.self).sorted(byKeyPath: ReadNews.keyForOrderBy(), ascending: ascending)
//        let startIndex = page * count
//        let endIdex = row.count <= (startIndex + count) ? row.count : (startIndex + count)
//        if !row.isEmpty, startIndex < endIdex {
//            let sliceArray = row[startIndex..<endIdex]
//            for readnews in sliceArray {
//                readNewses.append(readnews)
//            }
//        }
//
//        return readNewses
//    }
//
//    static func getReadNewses(with type:ChannelType) -> [ReadNews]? {
//        if !UserHelper.share.isCheckIn {
//            return nil
//        }
//
//        var readNewses = [ReadNews]()
//
//        let realm = try! Realm()
//        let row = getAllRows(realm: realm, type: ReadNews.self, filter: "channelType == '\(type.rawValue)'")
//        for readnews in row {
//            readNewses.append(readnews)
//        }
//        return readNewses
//    }
//
//    static func getReadCountOnlyNews() -> Int {
//        return getCount(type: ReadNews.self, filter: "channelType == '\(ChannelType.news.rawValue)'")
//    }
//
//}

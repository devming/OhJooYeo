//
//  RealmManager.swift
//  OhJooYeo
//
//  Created by Minki on 03/08/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit
import RealmSwift

enum RealmSchemeVersion:Int {
    case created = 1            // 최초 생성
//    case hubAdded = 2           // 기능1 추가
//    case funAdded = 3           // 기능2 추가
}

class RealmManager {
    private let realmFileName = "OhJooYeo"
    private let realmSchemeVersion = RealmSchemeVersion.created.rawValue
    static let share = RealmManager()
    
    private init() { }
    
    func getConfigration(userKey:String) -> Realm.Configuration {
        var config = Realm.Configuration(schemaVersion: UInt64.init(realmSchemeVersion), migrationBlock: { migration, oldVersion in
            print("migrationBlock \(oldVersion)")
//            if oldVersion < RealmSchemeVersion.hubAdded.rawValue {  // 허브 추가
//                //            // ex)
//                //                // 속성 생성 혹은 값 변경
//                migration.enumerateObjects(ofType: ReadNews.className(), { (oldObj, newObj) in
//                    newObj!["sectionCode"] = nil
//                    newObj!["channelType"] = ChannelType.news.rawValue
//                })
//            }
//
//            if oldVersion < RealmSchemeVersion.funAdded.rawValue {
//                migration.enumerateObjects(ofType: UserConfig.className(), { (oldObj, newObj) in
//                    newObj!["funScreenType"] = FunVcType.setting.rawValue
//                    newObj!["isShowFunNewAlert"] = true
//                    newObj!["funNewAlertShowCont"] = 0
//                })
//            }
            
            
            //            // 클래스 생성 및 값 추가
            //            migration.create(ReadNews.className(), value: ["sectionCode" : nil])
            //
            //            if oldVersion < 2 {
            //                // 속성 이름 변경
            //                migration.renameProperty(onType: ReadNews.className(), from: "sectionCode", to: "sectionValue")
            //            }
        })
        //        // config 파일 패스 직접 지정.
        //        config.fileURL = config.fileURL!.deletingLastPathComponent()
        //            .appendingPathComponent("\(realmFileName)_\(userKey).realm")
        
        config.deleteRealmIfMigrationNeeded = false
        
        return config
    }
    
    func setDefaultRealmForUser(userKey: String,
                                callBack: @escaping (Bool, Realm?, Error?) -> Void) {
        //        var config = Realm.Configuration()
        let config = getConfigration(userKey: userKey)
        
        //        config.schemaVersion = UInt64.init(realmSchemeVersion)
        //
        //        // 마이그레이션
        //        config.migrationBlock = { (migration, oldVersion) in
        //        }
        
        Realm.Configuration.defaultConfiguration = config
        do {
            let realm = try Realm()
            callBack(true, realm, nil)
            
        } catch let error as NSError {
            callBack(false, nil, error)
            print(error)
            
        }
        
        //        // Async가 필요할 경우
        //        Realm.asyncOpen(configuration: config, callbackQueue: DispatchQueue.main) { (realm, error) in
        //            if let realm = realm {
        //                self.realm = realm
        //                callBack(true, realm, nil)
        //
        //            } else {
        //                if let error = error {
        //                    print(error)
        //                }
        //                callBack(false, nil, error)
        //            }
        //        }
    }
    
    func removeRealmForUser(userKey: String) {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent()
            .appendingPathComponent("\(realmFileName)_\(userKey).realm")
        
        do {
            try FileManager.default.removeItem(at: config.fileURL!)
            
        } catch {
            print(error)
        }
        
    }
    
}

//
//  BaseRealm.swift
//  OhJooYeo
//
//  Created by Minki on 03/08/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import RealmSwift

class BaseRealm: NSObject {
    
    static func insertRow<T: Object>(row:T, update:Bool) -> Bool {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(row, update: update)
            }
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    
    static func removeRow<T: Object>(row:T) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(row)
        }
    }
    
    static func removeAllRow<T: Object>(type:T.Type) {
        let realm = try! Realm()
        let results = getAllRows(realm: realm, type: type)
        try! realm.write {
            for row in results {
                realm.delete(row)
            }
        }
    }
    
    static func isExsist<T: Object>(type:T.Type, key:String, value:Any) -> Bool {
        let realm = try! Realm()
        let row = getRow(realm: realm, type: type, key: key, value: value)
        
        if row != nil {
            return true
            
        } else {
            return false
            
        }
    }
    
    static func getRow<T:Object>(realm:Realm, type:T.Type, key:String, value:Any) -> T? {
        return getRow(realm: realm, type: type, filter: "\(key) = '\(value)'")
    }
    
    static func getRow<T:Object>(realm:Realm, type:T.Type, filter:String) -> T? {
        return realm.objects(type).filter(filter).first
    }
    
    static func getRows<T:Object>(realm:Realm, type:T.Type, key:String, value:Any) -> Results<T> {
        return getRows(realm: realm, type: type, filter: "\(key) = '\(value)'")
    }
    
    static func getRows<T:Object>(realm:Realm, type:T.Type, filter:String) -> Results<T> {
        return realm.objects(type).filter(filter)
    }
    
    ////     TODO 페이징 처리 로직 구현
    //    static func getRows<T:Object>(realm:Realm, type:T.Type, filter:String, page:Int, itemCount:Int) -> Results<T> {
    //        let result = realm.objects(type).filter(filter)
    //        return Results(result)
    //    }
    
    static func getAllRows<T:Object>(realm:Realm, type:T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    static func getAllRows<T:Object>(realm:Realm, type:T.Type, filter:String) -> Results<T> {
        return realm.objects(type).filter(filter)
    }
    
    static func getCount<T:Object>(type:T.Type) -> Int {
        let realm = try! Realm()
        return getAllRows(realm: realm, type: type).count
    }
    
    static func getCount<T:Object>(type:T.Type, filter:String) -> Int {
        let realm = try! Realm()
        return getAllRows(realm: realm, type: type, filter: filter).count
    }
    
}

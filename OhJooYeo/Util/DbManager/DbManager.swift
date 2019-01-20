//
//  DbManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift

final class DbManager {
    static let shared = DbManager()
    var realm: Realm?
    
    private init() {        // 싱글톤 구현할 때 기본적으로 private init으로 생성자를 만들어 준다. 그래야 밖에서 생성 못하니까.
        do {
            self.realm = try Realm()
        } catch {
            print("-> Realm Error = \(error)")
        }
    }
}

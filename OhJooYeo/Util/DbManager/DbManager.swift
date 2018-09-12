//
//  DbManager.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import CoreData

class DbManager{    // 싱글톤으로 구현할 것임
    static let shared = DbManager() /// 처음 사용할때 그때 생성되나?
    
//    var worshipMO: WorshipMO? {
//        get {
//            return NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.worshipEntityName, into: defaultContext) as? WorshipMO
//        }
//        set {}
//    }
//    var worshipOrderMO: WorshipOrderMO? {
//        get {
//            return NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.worshipOrderEntityName, into: defaultContext) as? WorshipOrderMO
//        }
//        set {}
//    }
//    var phraseMessageMO: PhraseMessageMO? {
//        get {
//            return NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.phraseMessageEntityName, into: defaultContext) as? PhraseMessageMO
//        }
//        set {}
//    }
//    var praiseMO: PraiseMO? {
//        get {
//            return NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.praiseEntityName, into: defaultContext) as? PraiseMO
//        }
//    }
//    var advertisement: AdvertisementMO? {
//        get {
//            return NSEntityDescription.insertNewObject(forEntityName: DbManager.EntityName.advertisementEntityName, into: defaultContext) as? AdvertisementMO
//        }
//        set {}
//    }
    
    private init() {        // 싱글톤 구현할 때 기본적으로 private init으로 생성자를 만들어 준다. 그래야 밖에서 생성 못하니까.
    }
    
    var selectedObj: NSManagedObject? /// CoreData로 읽어온 데이터를 저장할 수 있다.
    var modelName: String?
    
    func setup(with modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {     // 내부적으로 sqlite를 관리하는 녀석.
        guard let name = self.modelName else {
            //TODO: 잘못 된
            return NSPersistentContainer(name: "OhJooYeo")
        }
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var defaultContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func contextHasChanges() -> Bool {
        return self.defaultContext.hasChanges
    }
    
    // MARK: - Core Data Saving
    func saveContext () {
        
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()  // save메소드만 호출하면 다 저장된다.
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /// DELETE
    func delete(_ obj: NSManagedObject) {
        self.defaultContext.delete(obj)          /// context의 모든 작업은 메모리에서 이루어진다.
        saveContext()   /// 이걸 호출해야만!!! 실제로 지워진다.    context를 save해야 file에 저장이 된다.
    }
    
}
//guard let entity = NSEntityDescription.entity(forEntityName: DbManager.Name.worshipOrderEntityName, in: defaultContext) else {
//    return
//}
//guard let worshipOrderMO = NSManagedObject(entity: entity, insertInto: defaultContext) as? WorshipOrderMO else {
//    return
//}

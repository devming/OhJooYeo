//
//  Music.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 7. 14..
//  Copyright © 2018년 devming. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Music: Object {
    @objc dynamic var imageName: String = ""
    @objc dynamic var lyricist: String = ""
    @objc dynamic var composer: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var order: Int = -1
    let ownerWorshipData = LinkingObjects(fromType: WorshipData.self, property: "musics")
    //        var image: UIImage?
    //        var lylics: String
    
    convenience init(json: JSON) {
        self.init()
    }
    
//    init?(json: JSON) {
//        guard let lyricist = json[Name.lyricist].string else {
//            return nil
//        }
//        self.lyricist = lyricist
//        guard let title = json[Name.title].string else {
//            return nil
//        }
//        self.title = title
//        guard let order = json[Name.order].int else {
//            return nil
//        }
//        self.order = order
//        guard let imageName = json[Name.imageName].string else {
//            return nil
//        }
//        self.imageName = imageName
//        guard let composer = json[Name.composer].string else {
//            return nil
//        }
//        self.composer = composer
//        guard let category = json[Name.category].string else {
//            return nil
//        }
//        self.category = category
//        //            guard let lylics = json[Name.lylics].string else {
//        //                return nil
//        //            }
//        //            self.lylics = lylics
//
//        //            self.image = getImageData()
//    }
//
//    func getImageData() -> UIImage {
//
//        return UIImage()
//    }
}


extension Music {
    struct Name {
        static let imageName = "imageName"
        static let lyricist = "lyricist"
        static let title = "title"
        static let order = "order"
        static let composer = "composer"
        static let category = "category"
        static let lylics = "lylics"
    }
}

//
//  Music.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 7. 14..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Model {
    struct Music {
        var imageName: String
        var lyricist: String
        var composer: String
        var title: String
        var category: String
        var order: Int
//        var image: UIImage?
//        var lylics: String
        
        init?(json: JSON) {
            guard let lyricist = json[Name.lyricist].string else {
                return nil
            }
            self.lyricist = lyricist
            guard let title = json[Name.title].string else {
                return nil
            }
            self.title = title
            guard let order = json[Name.order].int else {
                return nil
            }
            self.order = order
            guard let imageName = json[Name.imageName].string else {
                return nil
            }
            self.imageName = imageName
            guard let composer = json[Name.composer].string else {
                return nil
            }
            self.composer = composer
            guard let category = json[Name.category].string else {
                return nil
            }
            self.category = category
//            guard let lylics = json[Name.lylics].string else {
//                return nil
//            }
//            self.lylics = lylics
            
//            self.image = getImageData()
        }
        
        func getImageData() -> UIImage {
            
            return UIImage()
        }
    }
}

extension Model.Music {
    struct Name {
        static let lyricist = "lyricist"
        static let title = "title"
        static let imageName = "imageName"
        static let order = "order"
        static let composer = "composer"
        static let category = "category"
        static let lylics = "lylics"
    }
}

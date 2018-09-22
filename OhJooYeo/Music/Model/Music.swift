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
        var lyricist: String
        var title: String
        var imageName: String
//        var image: UIImage?
        var order: Int
        var composer: String
        var category: String
        
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
    }
}

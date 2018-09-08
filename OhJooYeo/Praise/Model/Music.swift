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
        var id: String
        var title: String
        //var imageName: String
        var image: UIImage?
        var order: Int
        var content: String
        
        init?(json: JSON) {
            guard let id = json["id"].string else {
                return nil
            }
            self.id = id
            guard let title = json["title"].string else {
                return nil
            }
            self.title = title
            guard let order = json["order"].int else {
                return nil
            }
            self.order = order
            guard let content = json["content"].string else {
                return nil
            }
            self.content = content
            
            self.image = getImageData()
        }
        
        func getImageData() -> UIImage {
            
            return UIImage()
        }
    }
}

extension Model.Music {
    struct Name {
        static let id = "id"
        static let title = "title"
        static let order = "order"
        static let content = "content"
    }
}

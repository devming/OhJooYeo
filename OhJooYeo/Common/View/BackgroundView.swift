//
//  BackgroundView.swift
//  OhJooYeo
//
//  Created by Minki on 29/06/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class BackgroundView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        UIGraphicsBeginImageContext(self.frame.size)
        
        image = UIImage(named: "bg_all_blur")
        image?.draw(in: self.bounds)
        
        if let backImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.backgroundColor = UIColor(patternImage: backImage)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
        
        self.contentMode = .scaleAspectFill
    }
}

//
//  BackgroundView.swift
//  OhJooYeo
//
//  Created by Minki on 29/06/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

enum OJYError {
    case network
    case data
    case solved
}

class BackgroundView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        UIGraphicsBeginImageContext(self.frame.size)
        
        image = UIImage(named: "bg_all_blur")
        image?.draw(in: self.bounds)
        
        if let backImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.backgroundColor = UIColor(patternImage: backImage)
        } else {
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
        
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
    func showErrorView(_ error: OJYError, _ complete: () -> Void) {
        switch error {
        case .network:
            let errorView = NetworkErrorView(frame: self.frame)
            errorView.tag = 10
            self.addSubview(errorView)
        case .data:
            let errorView = NoDataErrorView(frame: self.frame)
            errorView.tag = 10
            self.addSubview(errorView)
        case .solved:
            self.subviews.forEach {
                let errorView = $0.viewWithTag(10)
                errorView?.removeFromSuperview()
            }
        }
        complete()
    }
}

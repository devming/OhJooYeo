//
//  BackgroundView.swift
//  OhJooYeo
//
//  Created by Minki on 29/06/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum OJYError: Int {
    case network = 10
    case data = 20
}

class BackgroundView: UIImageView {
    
    var disposeBag = DisposeBag()
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setBackgroundByColor()
    }
    
    func setBackgroundByColor() {
        self.backgroundColor = UIColor.colorBackgroundDark
    }
    
    func setBackgroundByImage() {
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
    
    func showErrorView(_ error: OJYError, _ reloadHandler: (() -> Void)? = nil) {
        switch error {
        case .network:
            let errorView = NetworkErrorView(frame: self.frame)
            errorView.tag = OJYError.network.rawValue
            errorView.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] _ in
                    reloadHandler?()
                    self?.errorSolved()
                }).disposed(by: disposeBag)
            self.addSubview(errorView)
        case .data:
            let errorView = NoDataErrorView(frame: self.frame)
            errorView.tag = OJYError.data.rawValue
            errorView.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] _ in
                    reloadHandler?()
                    self?.errorSolved()
                }).disposed(by: disposeBag)
            self.addSubview(errorView)
        
            
//            self.subviews.forEach {
//                $0.viewWithTag(OJYError.network.rawValue)?.removeFromSuperview()
//                $0.viewWithTag(OJYError.data.rawValue)?.removeFromSuperview()
//            }
        }
    }
    
    func errorSolved() {

        self.subviews
            .filter { $0.viewWithTag(OJYError.network.rawValue) != nil || $0.viewWithTag(OJYError.data.rawValue) != nil }
            .forEach({ view in
                view.removeFromSuperview()
            })
    }
    
}

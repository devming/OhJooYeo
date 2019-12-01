//
//  FullScreenModalNavigationController.swift
//  OhJooYeo
//
//  Created by Minki on 2019/12/01.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class FullScreenModalNavigationController: UIKit.UINavigationController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .fullScreen
    }
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.modalPresentationStyle = .fullScreen
    }
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.modalPresentationStyle = .fullScreen
    }
}

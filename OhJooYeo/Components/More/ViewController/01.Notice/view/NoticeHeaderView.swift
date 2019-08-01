//
//  NoticeHeaderView.swift
//  OhJooYeo
//
//  Created by Minki on 14/07/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class NoticeHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var customBackgroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expandButton: UIImageView!
    
    var item: NoticeModelItem? {
        didSet {
            guard let item = item else { return }
            titleLabel.text = item.title
            setCollapsed(collapsed: item.isCollapsed)
        }
    }
    static let headerName = "noticeHeader"
    static let xibName = "NoticeHeaderView"
    var section: Int = 0
    weak var delegate: HeaderViewDelegate?
    
    func initializer() {
        backgroundView = customBackgroundView
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializer()
    }
    
    func setData(date: String, title: String) {
        dateLabel.text = date
        titleLabel.text = title
    }
    
    func setCollapsed(collapsed: Bool, completionHandler: (() -> Void)? = nil) {
//        print("### collapsed: \(collapsed)")
        completionHandler?()
        expandButton.rotate(collapsed)
    }
    
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }
}

extension NoticeHeaderView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("### START")
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("### STOP")
    }
}

extension UIView {
    func rotate(_ collapsed: Bool, duration: CFTimeInterval = 0.1) {
        let toValue: CGFloat = collapsed ? 0.0 : .pi
//        let fromValue: CGFloat = !collapsed ? .pi*2 : .pi
        let animation = CABasicAnimation(keyPath: "transform.rotation")
//        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: "rotationButton")
    }
}

protocol HeaderViewDelegate: class {
    func toggleSection(header: NoticeHeaderView, section: Int)
}

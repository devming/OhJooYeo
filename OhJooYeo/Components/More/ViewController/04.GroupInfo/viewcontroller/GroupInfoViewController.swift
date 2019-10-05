//
//  GroupInfoViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class GroupInfoViewController: UIViewController {

    static let segueName = "groupInfoSegue"
    
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupContent: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    let viewModel = GroupInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        setViews(data: viewModel.loadGroupInfoDatas())
    }
    
    func setViews(data: GroupInfo?) {
        groupContent.text = data?.title
        groupContent.text = data?.content
        groupImageView.image = UIImage(named: data?.image ?? "img_young_intro")
    }
}

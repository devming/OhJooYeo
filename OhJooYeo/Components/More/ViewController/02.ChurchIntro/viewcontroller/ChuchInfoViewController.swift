//
//  ChurchInfoViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class ChurchInfoViewController: BaseViewController {

    static let segueName = "churchInfoSegue"
    
    @IBOutlet weak var churchInfoTitle: UILabel!
    @IBOutlet weak var churchInfoContent: UILabel!
    @IBOutlet weak var churchInfoImageView: UIImageView!
    
    let viewModel = ChurchInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        setViews(data: viewModel.loadChurchInfoDatas())
    }
    
    func setViews(data: ChurchInfo?) {
        churchInfoTitle.text = data?.title
        churchInfoContent.text = data?.content
        churchInfoImageView.image = UIImage(named: data?.image ?? "img_church_intro")
    }
}

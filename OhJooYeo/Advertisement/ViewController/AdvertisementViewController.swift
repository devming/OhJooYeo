//
//  AdvertisementViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class AdvertisementViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(advertisementUpdate(_:)), name: .AdvertisementDidUpdated, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listTableView.reloadData()
    }
}

extension AdvertisementViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let advertisementList = AdvertisementViewModel.shared.advertisements else {
            return 0
        }
        
        return advertisementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdvertisementTableViewCell.cellName) as? AdvertisementTableViewCell else {
            return UITableViewCell()
        }
        if let advertisementList = AdvertisementViewModel.shared.advertisements {
            cell.titleLabel.text = advertisementList[indexPath.row].title
            cell.descriptionLabel.text = advertisementList[indexPath.row].content
        }
        
        return cell
    }
    
    
}

extension AdvertisementViewController {
    @objc func advertisementUpdate(_ notification: Notification) {
        OperationQueue.main.addOperation { [weak self] in
            self?.listTableView.reloadData()
        }
    }
}

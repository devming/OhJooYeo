//
//  AdvertisementViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class AdvertisementViewController: BaseViewController {

    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var listTableView: UITableView!
    let viewModel = AdvertisementViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        NotificationCenter.default.addObserver(self, selector: #selector(advertisementUpdate(_:)), name: .AdvertisementDidUpdated, object: nil)
        
        initRefreshControl()
        setTransparentBackground()

        self.backgroundView.showErrorView(.network) {
            self.listTableView.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listTableView.reloadData()
    }
    
    func initRefreshControl() {
        self.refreshControl.addTarget(self, action: #selector(loadDatas), for: .valueChanged)
        self.listTableView.addSubview(self.refreshControl)
    }
    
    @objc func loadDatas() {
//        DispatchQueue.main.async {
//            App.loadAllDataFromServer { [weak self] in
//                App.isLoadingComplete = true
//                self?.refreshControl.endRefreshing()
//                NotificationCenter.default.post(name: .AdvertisementDidUpdated, object: nil)
//            }
//        }
    }
}

extension AdvertisementViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.advertisements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdvertisementTableViewCell.cellName) as? AdvertisementTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setItem(item: viewModel.advertisements[indexPath.row])

        return cell
    }
}

extension AdvertisementViewController {
//    @objc func advertisementUpdate(_ notification: Notification) {
//        if App.isLoadingComplete {
//            OperationQueue.main.addOperation { [weak self] in
//                self?.listTableView.isHidden = false
//                self?.listTableView.reloadData()
//                App.isLoadingComplete = false
//            }
//        } else {
//            self.backgroundView.showErrorView(.network) {
//                self.listTableView.isHidden = true
//            }
//        }
//    }
}

//
//  AdvertisementViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AdvertisementViewController: BaseViewController {

    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var listTableView: UITableView!
    let viewModel = AdvertisementViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initRefreshControl()
        setTransparentBackground()
        
        loadDatas()
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
        self.viewModel.requestAdvertisements()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                print("Success!")
                self?.listTableView.reloadData()
                self?.refreshControl.endRefreshing()
            }, onError: { [weak self] error in
                self?.refreshControl.endRefreshing()
                self?.backgroundView.showErrorView(.network)
            }).disposed(by: disposeBag)
    }
}

extension AdvertisementViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.advertisements?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdvertisementTableViewCell.cellName) as? AdvertisementTableViewCell else {
            return UITableViewCell()
        }
        
        if let advertisement = viewModel.advertisements?[indexPath.row] {
            cell.setItem(item: advertisement)
        }

        return cell
    }
}

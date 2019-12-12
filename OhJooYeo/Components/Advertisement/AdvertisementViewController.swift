//
//  AdvertisementViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDatas()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.backgroundView.errorSolved()
    }
    
    func initRefreshControl() {
        
        self.refreshControl.rx.controlEvent(.valueChanged)
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.loadDatas()
            }).disposed(by: disposeBag)
        self.listTableView.addSubview(self.refreshControl)
    }
    
    @objc func loadDatas() {
        setBackgroundSubViewsHide(isHidden: true)
        self.activityIndicator?.startAnimating()
        
        self.viewModel.requestAdvertisements()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.activityIndicator?.stopAnimating()
                self?.refreshControl.endRefreshing()
                guard let advertisements = data, advertisements.count == 0 else {
                    self?.backgroundView.showErrorView(.data) { [weak self] in
                        self?.loadDatas()
                    }
                    return
                }
                self?.listTableView.reloadData()
            }, onError: { [weak self] error in
                self?.reloadAction(errorType: .network)
            }).disposed(by: disposeBag)
    }
    
    func reloadAction(errorType: OJYError) {
        self.listTableView.reloadData()
        self.activityIndicator?.stopAnimating()
        self.refreshControl.endRefreshing()
        if errorType != .success {
            self.backgroundView.showErrorView(errorType) { [weak self] in
                self?.loadDatas()
            }
            return
        }
        setBackgroundSubViewsHide(isHidden: false)
    }
    
    func setBackgroundSubViewsHide(isHidden: Bool) {
        self.listTableView.subviews.forEach {
            $0.isHidden = isHidden
        }
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

//
//  HistoryViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit
import RxSwift

class HistoryViewController: UIViewController {

    let viewModel = WorshipIDListDataViewModel()
    var mainViewModel: WorshipMainInfoViewModel? {
        didSet {
            print("mainViewModel is set in HistoryViewController")
        }
    }
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var refreshButton: UIButton!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setTransparentBackground(navigationController: self.navigationController)
//        navigationBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        callApi()
        
        refreshButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.callApi()
            }).disposed(by: disposeBag)
    }

    func callApi() {
        viewModel.requestWorshipList()
            .asDriver(onErrorJustReturn: [WorshipIdDate]())
            .drive(onNext: { [weak self] _ in
                self?.listTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {

            if let mainViewController = self.presentingViewController as? MainViewController {
                self.dismiss(animated: true) {
                    mainViewController.listTableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        disposeBag = DisposeBag()
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let worshipIdDateList = self.viewModel.worshipIdDateList else {
            return 0
        }
        return worshipIdDateList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellName) as? HistoryTableViewCell, let cellItems = viewModel.worshipIdDateList else {
            return UITableViewCell()
        }
        
        cell.dateLabel.text = cellItems[indexPath.row].date
        cell.borderLine.isHidden = indexPath.row == cellItems.count - 1
        
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /// - TODO: Loading Progress.
        /// - TODO: Local에서 해당하는 ID의 데이터를 불러온다.
        
        /// - 선택한것 가지고 불러오고 main view controller 업데이트하기
        /// 1. 선택한다.
        /// 2. 선택한 WorshipId로 주보 내용 불러온다.
        /// 3. 현재 창을 종료
        /// 4. 불러온 내용을 가지고 main view controller 업데이트
        if let id = viewModel.worshipIdDateList?[indexPath.row].worshipId {
            mainViewModel?.requestWorshipMain(worshipId: id)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (worshipInfo) in
                    if let mainViewController = self.presentingViewController as? MainViewController {
                        mainViewController.viewModel.worshipInfo = worshipInfo
                        self.dismiss(animated: true) {
                            mainViewController.listTableView.reloadData()
                        }
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

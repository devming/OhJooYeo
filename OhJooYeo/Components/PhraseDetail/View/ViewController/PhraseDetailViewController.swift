//
//  PhraseDetailViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class PhraseDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var listTableView: UITableView!
    var orderId = 0
    var currentIndex = -1
    var phraseRange: String?
    let viewModel = PhraseMessageViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(phraseMessageUpdate(_:)), name: .PhraseMessageDidUpdated, object: nil)
        
        setTransparentBackground(navigationController: self.navigationController)
        
        ///////// test code////////////////////////////////////
        if phraseRange == "행복의 노래" {
                    backgroundView.showErrorView(.data) { [weak self] in
                        let temp = "창세기 1:3-1:5"
                        var range = [String]()
            //            range.append(phraseRange)
                        range.append(temp)
                        self?.callApi(phraseRange: range)
                    }
            return
        }
        ///////////////////////////////////////////////////////////////
        if let phraseRange = phraseRange {
            let temp = "창세기 1:3-1:5"
            var range = [String]()
//            range.append(phraseRange)
            range.append(temp)
            callApi(phraseRange: range)
        } else {
            /// TODO: 에러화면 띄우기
            backgroundView.showErrorView(.data)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        guard let worshipID = viewModel.worshipData?.worshipID else {
//            return
//        }
//        let result = WholeWorshipDataDAO.shared.getResultPhraseMessages(by: worshipID)
//        WorshipMainInfoViewModel.shared.worshipDataObject.phraseMessageSetList = result?.toArray(ofType: PhraseMessageSet.self)
//
//        var index = -1
//        WholeWorshipDataDAO.shared.phraseMessageSetList?.forEach({ (set) in
//            index += 1
//            guard let orderID = set.worshipOrderID.split(separator: "_").last else {
//                return
//            }
//            if orderID == "\(self.orderID)" {
//                self.currentIndex = index
//            }
//        })
        
        self.listTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    func callApi(phraseRange: [String]) {
        viewModel.requestPhraseMessage(phraseRange: phraseRange)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.listTableView.reloadData()
            }, onError: { [weak self] error in
                self?.backgroundView.showErrorView(.network)
            }).disposed(by: disposeBag)
    }
}

extension PhraseDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.phrases?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.phrases?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhraseDetailTableViewCell.cellName) as? PhraseDetailTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setItem(item: viewModel.phrases?[indexPath.section][indexPath.row])
        
//        if let phraseMessageSetList = WholeWorshipDataDAO.shared.phraseMessageSetList {
//            let phraseMessageList = phraseMessageSetList[self.currentIndex].phraseMessageList
//            cell.phraseKeyLabel.text = phraseMessageList[indexPath.row].phraseKey
//            cell.phraseMessageLabel.text = phraseMessageList[indexPath.row].contents
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return phraseRange
    }
}

extension PhraseDetailViewController {
//    @objc func phraseMessageUpdate(_ notification: Notification) {
//        OperationQueue.main.addOperation { [weak self] in
//            self?.listTableView.reloadData()
//        }
//    }
}


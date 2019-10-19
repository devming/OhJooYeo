//
//  PhraseDetailViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit
import RealmSwift

class PhraseDetailViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    var orderID = 0
    var currentIndex = -1
    let viewModel = PhraseMessageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(phraseMessageUpdate(_:)), name: .PhraseMessageDidUpdated, object: nil)
        
        setTransparentBackground(navigationController: self.navigationController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let worshipID = viewModel.worshipData?.worshipID else {
            return
        }
        let result = WholeWorshipDataDAO.shared.getResultPhraseMessages(by: worshipID)
        WorshipMainInfoViewModel.shared.worshipDataObject.phraseMessageSetList = result?.toArray(ofType: PhraseMessageSet.self)
        
        var index = -1
        WholeWorshipDataDAO.shared.phraseMessageSetList?.forEach({ (set) in
            index += 1
            guard let orderID = set.worshipOrderID.split(separator: "_").last else {
                return
            }
            if orderID == "\(self.orderID)" {
                self.currentIndex = index
            }
        })
        
        self.listTableView.reloadData()
    }
}

extension PhraseDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let phraseMessageSetList = WholeWorshipDataDAO.shared.phraseMessageSetList else {
            return 0
        }
        return phraseMessageSetList[self.currentIndex].phraseMessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhraseDetailTableViewCell.cellName) as? PhraseDetailTableViewCell else {
            return UITableViewCell()
        }
        
        if let phraseMessageSetList = WholeWorshipDataDAO.shared.phraseMessageSetList {
            let phraseMessageList = phraseMessageSetList[self.currentIndex].phraseMessageList
            cell.phraseKeyLabel.text = phraseMessageList[indexPath.row].phraseKey
            cell.phraseMessageLabel.text = phraseMessageList[indexPath.row].contents
        }
        
        return cell
    }
}

extension PhraseDetailViewController {
    @objc func phraseMessageUpdate(_ notification: Notification) {
        OperationQueue.main.addOperation { [weak self] in
            self?.listTableView.reloadData()
        }
    }
}


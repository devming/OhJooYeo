//
//  PhraseDetailViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class PhraseDetailViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    var orderId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(phraseMessageUpdate(_:)), name: .PhraseMessageDidUpdated, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listTableView.reloadData()
    }
}

extension PhraseDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let phraseList = PhraseMessageCellData.shared.phraseMessages, let phraseMessage = phraseList[self.orderId] else {
            return 0
        }
        
        return phraseMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhraseDetailTableViewCell.cellName) as? PhraseDetailTableViewCell else {
            return UITableViewCell()
        }
        
        if let phraseList = PhraseMessageCellData.shared.phraseMessages, let phraseMessages = phraseList[self.orderId] {
            cell.phraseKeyLabel.text = phraseMessages[indexPath.row].phraseKey
            cell.phraseMessageLabel.text = phraseMessages[indexPath.row].content
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


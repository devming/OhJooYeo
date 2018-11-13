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
    var orderId: Int32 = 0
    
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
        guard let phraseList = PhraseMessageCellData.shared.phraseMessages else {
            return 0
        }
        
        return phraseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhraseDetailTableViewCell.cellName) as? PhraseDetailTableViewCell else {
            return UITableViewCell()
        }
        
        if let phraseLists = PhraseMessageCellData.shared.phraseMessages {
            
            /// TODO: order id 에 따라 다른 걸 뿌려주도록.
            
            cell.phraseKeyLabel.text = phraseLists[Int(self.orderId)][indexPath.row].phraseKey
            cell.phraseMessageLabel.text = phraseLists[Int(self.orderId)][indexPath.row].content
            
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


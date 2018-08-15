//
//  PhraseDetailViewController.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 5. 26..
//  Copyright © 2018년 devming. All rights reserved.
//

import UIKit

class PhraseDetailViewController: UIViewController {

    var phraseList: [Model.PhraseMessage]?
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        makeDummyDatas()
        self.listTableView.reloadData()
    }

}

extension PhraseDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let phraseList = self.phraseList else {
            return 0
        }
        return phraseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhraseDetailTableViewCell.cellName) as! PhraseDetailTableViewCell
        
        if let phraseList = self.phraseList {
            cell.phraseKeyLabel.text = phraseList[indexPath.row].phraseKey
            cell.phraseMessageLabel.text = phraseList[indexPath.row].phraseMessage
        }
        
        return cell
    }
    
    
    
}

extension PhraseDetailViewController {
    func makeDummyDatas() {
        self.phraseList = [Model.PhraseMessage]()
        
        self.phraseList?.append(Model.PhraseMessage(phraseKey: "(욘 2:7)", phraseMessage: "내 영혼이 내 속에서 피곤할 때에 내가 여호와를 생각하였더니 내 기도가 주께 이르렀사오며 주의 성전에 미쳤나이다"))
        self.phraseList?.append(Model.PhraseMessage(phraseKey: "(욘 2:8)", phraseMessage: "거짓되고 헛된 것을 숭상하는 모든 자는 자기에게 베푸신 은혜를 버렸사오니"))
        self.phraseList?.append(Model.PhraseMessage(phraseKey: "(욘 2:9)", phraseMessage: "나는 감사하는 목소리로 주께 제사를 드리며 나의 서원을 주께 갚겠나이다 구원은 여호와께 속하였나이다 하니라"))
        self.phraseList?.append(Model.PhraseMessage(phraseKey: "(욘 2:10)", phraseMessage: "여호와께서 그 물고기에게 말씀하시매 요나를 육지에 토하니라"))
    }
}

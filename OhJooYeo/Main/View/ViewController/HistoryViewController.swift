//
//  HistoryViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    var worshipIDList: [WorshipIDDate]?
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.worshipIDList = WorshipIDListDAO.shared.worshipIDDateList
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let worshipIDList = self.worshipIDList else {
            return 0
        }
        return worshipIDList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellName) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
//        cell.worshipIDLabel.text = self.worshipIDList?[indexPath.row].worshipID
        cell.dateLabel.text = self.worshipIDList?[indexPath.row].date
        
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /// - TODO: Loading Progress.
        /// - TODO: Local에서 해당하는 ID의 데이터를 불러온다.
        guard let worshipIDList = self.worshipIDList else {
            showConfirmationAlert(alertTitle: "값이 없습니다.", alertMessage: "WorshipIDList 데이터 에러", viewController: self)
            return
        }
        if let data = WholeWorshipDataDAO.shared.getResult(worshipID: worshipIDList[indexPath.row].worshipID)?.first {
            WholeWorshipDataDAO.shared.worshipData = data
            /// data를 MainViewController로 보내야함
        }
        
        /// - TODO: Notification보내서
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: .WorshipDidUpdated, object: nil)
        }
    }
}

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
        
//        setTransparentBackground(navigationController: self.navigationController)
//        navigationBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
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
        guard let worshipIDList = self.worshipIDList,
            let data = WholeWorshipDataDAO.shared.getResult(worshipID: worshipIDList[indexPath.row].worshipID)?.first else {
            showConfirmationAlert(alertTitle: "오류", alertMessage: "해당 날짜 주보가 없습니다.", viewController: self)
            return
        }
        /// data를 MainViewController로 보내야함
        WholeWorshipDataDAO.shared.worshipData = data
        WorshipMainInfoViewModel.shared.setDate()
        App.isLoadingComplete = true
        
        /// - TODO: Notification보내서
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: .WorshipDidUpdated, object: nil)
        }
    }
}

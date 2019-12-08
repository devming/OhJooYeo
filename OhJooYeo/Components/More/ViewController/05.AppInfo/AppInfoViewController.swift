//
//  AppInfoViewController.swift
//  OhJooYeo
//
//  Created by Minki on 20/07/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {

    static let segueName = "appInfoSegue"
    
    let list = ["애플리케이션 버전 정보", "오픈소스 라이선스"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.layer.cornerRadius = 10.0
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension AppInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppInfoCell.cellName, for: indexPath) as? AppInfoCell else { return UITableViewCell() }
        
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
}

extension AppInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueName = indexPath.row == 0 ? SegueName.versionInfoSegue.rawValue : SegueName.opensourceSegue.rawValue
        performSegue(withIdentifier: segueName, sender: tableView.cellForRow(at: indexPath))
    }
}

class AppInfoCell: UITableViewCell {
    static let cellName = "AppInfoCell"
}

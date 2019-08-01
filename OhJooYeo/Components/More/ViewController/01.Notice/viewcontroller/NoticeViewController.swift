//
//  NoticeViewController.swift
//  OhJooYeo
//
//  Created by Minki on 16/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NoticeViewController: UIViewController {

    static let segueName = "noticeSegue"
    let viewModel = NoticeViewModel()
    @IBOutlet weak var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        viewModel.setTestData()
        viewModel.reloadSections = { [weak self] (section: Int) in
            guard let `self` = self else { return }
            self.noticeTableView.beginUpdates()
            self.noticeTableView.reloadSections([section], with: .fade)
            
//            UIView.transition(with: self.noticeTableView,
//                              duration: 0.35,
//                              options: .transitionCrossDissolve,
//                              animations: { self.noticeTableView.reloadData() })
            self.noticeTableView.endUpdates()
        }
        
//        setTransparentBackground(navigationController: self.navigationController)
        
        setup()
//        noticeTableView.reloadData()
    }
    
    func setup() {
        let headerNib = UINib(nibName: NoticeHeaderView.xibName, bundle: nil)
        
        noticeTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: NoticeHeaderView.headerName)
    }
    
    func bindRx() {
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NoticeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfDatas
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = viewModel.items[section]
        if item.isCollapsible && item.isCollapsed {
            return 0
        }
        return item.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.cellName) as? NoticeCell else { return UITableViewCell() }
        
        cell.contentLabel.text = viewModel.items[indexPath.section].content
        
        return cell
    }
}

extension NoticeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NoticeHeaderView.headerName) as? NoticeHeaderView else { return UIView() }

        headerView.item = viewModel.items[section]
        headerView.titleLabel.text = viewModel.items[section].title
        headerView.dateLabel.text = "\(viewModel.items[section].date)"
        headerView.section = section
        headerView.delegate = viewModel.self
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

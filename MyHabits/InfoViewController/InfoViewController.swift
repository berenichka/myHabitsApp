//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Veronika Torushko on 17.06.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    private let indent = 16
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let cellId = "cellId"
    private var infoData = [InfoSection]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация"
        view.addSubview(tableView)
        setupTableView()
        self.infoData = InfoStorage.tableModel
        self.tableView.separatorColor = .white
        self.tableView.backgroundColor = .white
    }
    
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(InfoTableHeaderView.self, forHeaderFooterViewReuseIdentifier: InfoTableHeaderView.reuseId)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 62).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(indent)).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(indent)).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }


}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return infoData[section].text.count
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        
        return infoData.count
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InfoTableViewCell
        
        cell.textLine = infoData[indexPath.section].text[indexPath.row]
        
        return cell
        
    }
    
}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = InfoTableHeaderView()
        let infoSection = infoData[section]
        header.infoSection = infoSection
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = InfoTableFooterView()
        let infoSection = infoData[section]
        footer.infoSection = infoSection
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

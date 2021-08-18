//
//  HabitDetailTableHeaderView.swift
//  MyHabits
//
//  Created by Veronika Torushko on 18.07.2021.
//

import UIKit

class HabitDetailTableHeaderView: UITableViewHeaderFooterView {
    
    static let reuseId = String(describing: HabitDetailTableHeaderView.self)
    
    
    private let headerLabel: UILabel = {
        let header = UILabel()
        header.text = "АКТИВНОСТЬ"
        header.textColor = UIColor(named: "HeaderGray")?.withAlphaComponent(0.6)
        header.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return header
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(headerLabel)
        contentView.backgroundColor = .white
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6.5).isActive = true
        headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

//
//  InfoTableHeaderView.swift
//  MyHabits
//
//  Created by Veronika Torushko on 19.06.2021.
//

import UIKit

class InfoTableHeaderView: UITableViewHeaderFooterView {
    
    static let reuseId = String(describing: InfoTableHeaderView.self)
    
    var infoSection: InfoSection? {
        didSet {
            headerLabel.text = infoSection?.title
        }
    }
    
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(headerLabel)
        contentView.backgroundColor = .white
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        headerLabel.widthAnchor.constraint(equalToConstant: 218).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

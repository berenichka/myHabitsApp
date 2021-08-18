//
//  InfoTableFooterView.swift
//  MyHabits
//
//  Created by Veronika Torushko on 20.06.2021.
//

import UIKit

class InfoTableFooterView: UITableViewHeaderFooterView {
    static let reuseId = String(describing: InfoTableFooterView.self)
    
    var infoSection: InfoSection? {
        didSet {
            footerLabel.text = infoSection?.footer
        }
    }
    
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(footerLabel)
        contentView.backgroundColor = .white
        
        
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        footerLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        footerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        footerLabel.widthAnchor.constraint(equalToConstant: 211).isActive = true
        footerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

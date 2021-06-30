//
//  InfoTableViewCell.swift
//  MyHabits
//
//  Created by Veronika Torushko on 19.06.2021.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    private let edgeIndent = 16
    private let verticalIndent = 12
    
    private let infoText: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.textColor = .black
        text.numberOfLines = 0
        return text
    }()
    
    
    var textLine: InfoLines? {
        didSet {
            infoText.text = textLine?.text
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        infoText.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoText)
        infoText.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        infoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        infoText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CGFloat(verticalIndent)).isActive = true
//        
    }

}

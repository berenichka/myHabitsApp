//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Veronika Torushko on 21.06.2021.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit? {
        didSet {
            nameLabel.textColor = habit?.color
            nameLabel.text = habit?.name
            timeLabel.text = habit?.dateString
            colorCircleButton.layer.borderColor = habit?.color.cgColor
        }
    }
       
    private let indent = 20
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private var countLabel: UILabel = {
        var label = UILabel()
        label.sizeToFit()
        label.text = "Счётчик: "
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let colorCircleButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.cornerRadius = CGFloat(button.frame.width / 2)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(colorCircleButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFrames() {
        nameLabel.frame = CGRect(x: CGFloat(indent), y: CGFloat(indent), width: 220, height: 22)
        timeLabel.frame = CGRect(x: CGFloat(indent), y: CGFloat(nameLabel.frame.maxY) + 4, width: 117, height: 16)
        countLabel.frame = CGRect(x: CGFloat(indent), y: CGFloat(timeLabel.frame.maxY) + 30, width: 188, height: 18)
        colorCircleButton.frame = CGRect(x: CGFloat(self.frame.maxX) - 25, y: CGFloat(self.frame.midY), width: 38, height: 38)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrames()
        
    }
   
}



//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Veronika Torushko on 21.06.2021.
//

import UIKit

protocol HabitProgressCollectionViewCellDelegate: class {
    func reloadData()
}


class HabitsCollectionViewCell: UICollectionViewCell {
    
    
    weak var delegate: HabitProgressCollectionViewCellDelegate?
    
    var habit: Habit? {
        didSet {
            nameLabel.textColor = habit?.color
            nameLabel.text = habit?.name
            timeLabel.text = habit?.dateString
            colorCircleButton.layer.borderColor = habit?.color.cgColor
            countLabel.text = "Счетчик: \(habit?.trackDates.count ?? 0)"
            
            if self.habit?.isAlreadyTakenToday == true {
                colorCircleButton.backgroundColor = habit?.color
                buttonChecked()
            } else {
                colorCircleButton.backgroundColor = .white
            }
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
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        var label = UILabel()
        
        label.sizeToFit()
        label.text = "Счётчик: "
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var colorCircleButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 19
        button.addTarget(self, action: #selector(circleButtonTapped), for: .touchUpInside)
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
        
        setupFrames()
        buttonChecked()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupFrames() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(indent)).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(indent)).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(indent)).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(indent)).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 188).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        colorCircleButton.translatesAutoresizingMaskIntoConstraints = false
        colorCircleButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorCircleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -26).isActive = true
        colorCircleButton.widthAnchor.constraint(equalToConstant: 38).isActive = true
        colorCircleButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
    }
    
    
    func buttonStateUpdated() {
        colorCircleButton.backgroundColor = habit?.color
        let size = UIFont.systemFont(ofSize: 17, weight: .semibold)
        let imageParameters = UIImage.SymbolConfiguration(font: size)
        let image = UIImage(systemName: "checkmark", withConfiguration: imageParameters)
        colorCircleButton.setImage(image, for: .normal)
        colorCircleButton.tintColor = .white
    }
    
    @objc func circleButtonTapped() {
        
        if habit?.isAlreadyTakenToday == false {
        colorCircleButton.backgroundColor = habit?.color
        
        buttonChecked()
        HabitsStore.shared.track(habit!)
        countLabel.text = "Счётчик: \(habit?.trackDates.count ?? 0)"
        
        delegate?.reloadData()
            
        }
    }
    
    func buttonChecked() {
        let size = UIFont.systemFont(ofSize: 17, weight: .semibold)
        let imageParameters = UIImage.SymbolConfiguration(font: size)
        let image = UIImage(systemName: "checkmark", withConfiguration: imageParameters)
        colorCircleButton.setImage(image, for: .normal)
        colorCircleButton.tintColor = .white
    }
   
}



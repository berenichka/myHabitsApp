//
//  HabitDetailTableViewCell.swift
//  MyHabits
//
//  Created by Veronika Torushko on 10.07.2021.
//

import UIKit

class HabitDetailTableViewCell: UITableViewCell {

    private let leftIndent = 16
    private let rightIndent = 14
    private let topIndent = 11
    
    
    private let datesStore = HabitsStore.shared.dates
    
    var dayLine: HabitsStore? {
        didSet {
            dayLabel.text = dayLine?.trackDateString(forIndex: Int())
        }
    }
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat(topIndent)).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(leftIndent)).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: CGFloat(contentView.frame.width / 2)).isActive = true
        dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CGFloat(topIndent)).isActive = true
        
    }

}

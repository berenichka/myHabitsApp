//
//  HabitProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Veronika Torushko on 28.06.2021.
//

import UIKit




class HabitProgressCollectionViewCell: UICollectionViewCell {
    

    let store = HabitsStore.shared
    private let topIndent = 10
    private let bottomIndent = 15
    private let sideIndent = 12
    
    
    
    private let mottoLabel: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Int(store.todayProgress * 100))%"
        label.textAlignment = .right
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    lazy var progressBar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.trackTintColor = UIColor(named: "ProgressGray")
        bar.progressTintColor = UIColor(named: "Purple")
        bar.progress = store.todayProgress
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubview(mottoLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressBar)
        
        setupFrames()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupFrames() {
        mottoLabel.translatesAutoresizingMaskIntoConstraints = false
        mottoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(topIndent)).isActive = true
        mottoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(sideIndent)).isActive = true
        mottoLabel.widthAnchor.constraint(equalToConstant: CGFloat((self.frame.width - CGFloat(sideIndent * 2)) / 3 * 2)).isActive = true
        mottoLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(topIndent)).isActive = true
        percentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -CGFloat(sideIndent)).isActive = true
        percentLabel.widthAnchor.constraint(equalToConstant:  CGFloat((self.frame.width - CGFloat(sideIndent * 2)) / 3 * 1)).isActive = true
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.topAnchor.constraint(equalTo: mottoLabel.bottomAnchor, constant: 10).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(sideIndent)).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -CGFloat(sideIndent)).isActive = true
        

    }
    
    
}

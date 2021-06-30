//
//  HabitProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Veronika Torushko on 28.06.2021.
//

import UIKit

class HabitProgressCollectionViewCell: UICollectionViewCell {
    
    var progress: ProgressCell? {
        didSet {
            mottoLabel.text = progress?.motto
            percentLabel.text = progress?.percent
            progressBar.progress = progress?.progress ?? 0
        }
    }
    
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
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.text = "50%"
        label.textAlignment = .right
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.trackTintColor = UIColor(named: "ProgressGray")
        progress.progressTintColor = UIColor(named: "Purple")
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubview(mottoLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrames()
        
    }
    
    func setupFrames() {
        mottoLabel.frame = CGRect(x: CGFloat(sideIndent), y: CGFloat(topIndent), width: (self.frame.width - CGFloat(sideIndent) * 2) / 3 * 2, height: 18)
        percentLabel.frame = CGRect(x: mottoLabel.frame.maxX, y: CGFloat(topIndent), width: (self.frame.width - CGFloat(sideIndent) * 2) / 3 * 1, height: 18)
        progressBar.frame = CGRect(x: CGFloat(sideIndent), y: mottoLabel.frame.maxY + 10, width: self.frame.width - CGFloat(sideIndent) * 2, height: 7)
    }
    
}

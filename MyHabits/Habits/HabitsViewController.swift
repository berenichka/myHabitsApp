//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Veronika Torushko on 17.06.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private enum Section {
        case HabitsAdded
        case Progress
        case Unknown
      
        
        init(section: Int) {
            switch section {
            case 0: self = .Progress
            case 1: self = .HabitsAdded
            default:
                self = .Unknown
            }
        }
    }
    
    private let habitCellId = "habitCell"
    private let leftIndent = 16
    private let rightIndent = 17
    
    private var myProgress: [ProgressSection] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitsCollectionViewCell.self))
        collectionView.register(HabitProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitProgressCollectionViewCell.self))
        collectionView.backgroundColor = .green
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Сегодня"
        return label
    }()

    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addButtonSymbol"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    @objc func habitCreateChange() {

        if let habitViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "habit") as? HabitViewController {
            let navigationController = UINavigationController(rootViewController: habitViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(named: "lightGrayCustom")
        view.addSubview(topView)
        view.addSubview(collectionView)
        topView.addSubview(titleLabel)
        topView.addSubview(addButton)
        
        self.navigationController?.modalPresentationStyle = .fullScreen
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 92).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 14).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 141).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8).isActive = true
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 44).isActive = true
        addButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -5).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor).isActive = true
        addButton.addTarget(self, action: #selector(habitCreateChange), for: .touchUpInside)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(leftIndent)).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(rightIndent)).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -CGFloat(10)).isActive = true

 
    }

}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat
        width = (collectionView.frame.width - CGFloat(leftIndent) - CGFloat(rightIndent))
        
        let height: CGFloat
        switch Section(section: indexPath.section) {
        case .Progress :
            height = 60
        case .HabitsAdded :
            height = 130
        case .Unknown:
            height = 0
        }
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: CGFloat(leftIndent), bottom: 22, right: CGFloat(rightIndent))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    
}


extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(section: indexPath.section) {
        case .HabitsAdded:
            let cellTypeHabit = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitsCollectionViewCell.self), for: indexPath) as! HabitsCollectionViewCell
            
            if indexPath.section == 1 {
                cellTypeHabit.habit = HabitsStore.shared.habits[indexPath.item]}
                return cellTypeHabit
            
        case .Progress:
            let cellTypeProgress = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitProgressCollectionViewCell.self), for: indexPath) as! HabitProgressCollectionViewCell
            if indexPath.section == 0 {
                cellTypeProgress.progress = myProgress[indexPath.item].data[indexPath.item]}
            return cellTypeProgress
            
        case .Unknown:
            return UICollectionViewCell()
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
}

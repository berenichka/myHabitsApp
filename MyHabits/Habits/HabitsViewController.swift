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
    
    private var myProgress: Float = HabitsStore.shared.todayProgress {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var myHabits: [Habit] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitsCollectionViewCell.self))
        collectionView.register(HabitProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitProgressCollectionViewCell.self))
        collectionView.backgroundColor = UIColor(named: "lightGrayCustom")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let placeHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    @objc func habitCreate() {

        if let habitViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "habit") as? HabitViewController {
            let navigationController = UINavigationController(rootViewController: habitViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "lightGrayCustom")
        view.addSubview(placeHolderView)
        view.addSubview(collectionView)
        view.sendSubviewToBack(placeHolderView)
   

        title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "NavBarWhite")
        self.navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        self.navigationController?.modalPresentationStyle = .fullScreen
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "addButtonSymbol"), style: .plain, target: self, action: #selector(habitCreate))
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        
        placeHolderView.translatesAutoresizingMaskIntoConstraints = false
        placeHolderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        placeHolderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        placeHolderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        placeHolderView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: placeHolderView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.myHabits = HabitsStore.shared.habits
        let cellTypeHabit = HabitsCollectionViewCell()
        if cellTypeHabit.habit?.isAlreadyTakenToday == true {
            cellTypeHabit.buttonStateUpdated()
        }
    }

}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat
        width = collectionView.frame.width - CGFloat(leftIndent) - CGFloat(rightIndent)
        
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
        return UIEdgeInsets(top: 22, left: 16, bottom: 10, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    
}


extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            
            return myHabits.count
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(section: indexPath.section) {
        case .HabitsAdded:
            let cellTypeHabit = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitsCollectionViewCell.self), for: indexPath) as! HabitsCollectionViewCell

            if indexPath.section == 1 {
                cellTypeHabit.habit = myHabits[indexPath.item]
                cellTypeHabit.delegate = self
            }
            
                return cellTypeHabit

        case .Progress:
            let cellTypeProgress = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitProgressCollectionViewCell.self), for: indexPath) as! HabitProgressCollectionViewCell
            cellTypeProgress.updateProgress()
            
          
            return cellTypeProgress

        case .Unknown:
            return UICollectionViewCell()
        }
            
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1: let vc = HabitDetailsViewController(habit: HabitsStore.shared.habits[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)

        default: break
            
        }
    }
    
}


extension HabitsViewController: HabitProgressCollectionViewCellDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
    
    


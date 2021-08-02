//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Veronika Torushko on 08.07.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let cellId = "cellIdDetails"
    
    var habit: Habit
    
    init(habit: Habit){
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = habit.name
        view.addSubview(tableView)
        setupTableView()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(habitChange))
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Purple")

    
    }
    
    func setupTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(InfoTableHeaderView.self, forHeaderFooterViewReuseIdentifier: InfoTableHeaderView.reuseId)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    @objc func habitChange() {
        
        if let habitViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "habit") as? HabitViewController {
            let navigationController = UINavigationController(rootViewController: habitViewController)
            habitViewController.habit = habit
            navigationController.modalPresentationStyle = .fullScreen

            self.navigationController?.present(navigationController, animated: true, completion: nil)
            
        }
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = habit.name
    }
    


}


extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return HabitsStore.shared.dates.count
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let datesTaken = HabitsStore.shared.dates.count - indexPath.item - 1
        cell.textLabel?.text = "\(HabitsStore.shared.trackDateString(forIndex: datesTaken) ?? "")"
        cell.tintColor = UIColor(named: "Purple")
        let habitChecked = self.habit
        let date = HabitsStore.shared.dates[datesTaken]
        if HabitsStore.shared.habit(habitChecked, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
        
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HabitDetailTableHeaderView()
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


}

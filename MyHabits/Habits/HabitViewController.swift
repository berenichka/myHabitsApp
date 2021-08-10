//
//  HabitView.swift
//  MyHabits
//
//  Created by Veronika Torushko on 21.06.2021.
//
//
import UIKit

class HabitViewController: UIViewController {
    
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    var habit: Habit? {
        didSet {
            if let habitChange = habit {
                navigationItem.title = "Править"
                habitText.text = habitChange.name
                circleColorButton.backgroundColor = habitChange.color
                timePicker.date = habitChange.date
                timeText.text = habitChange.dateString
            }
            else {
        
                navigationItem.title = "Создать"
                habitDeleteButton.isHidden = true
            }
        }
    }
    
 
    
    private let sideIndent = 16
    private let smallIndent = 7
    private let indent = 15
    private let heightIndent = 18
    
    private let scrollView = UIScrollView()
    private let habitView = UIView()
    
    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let habitText: UITextField = {
        let text = UITextField()
        text.textColor = UIColor(named: "Blue")
        text.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        text.tintColor = UIColor(named: "Blue")
        text.placeholder = "Бегать по утрам, спать 8 часов и т.п."

        return text
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let circleColorButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(named: "Orange")
        return button
    }()
    
    
  
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    

    private var timeText: UILabel = {
        let text = UILabel()
        text.text = "Каждый день в "
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return text
        
    }()
    
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        let localeID = Locale.current
        picker.locale = localeID
        picker.preferredDatePickerStyle = .wheels
        
        return picker
    }()
    
    private let habitDeleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(UIColor(named: "Red"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    

    
    @objc func timeChanged() {
        let formatter  = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        
        
        timeText.text! = "Каждый день в \(formatter.string(from: timePicker.date))"
    }
    
    @objc func cancelBarButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func saveBarButtonPressed() {
        if let habitChanged = self.habit {
            habitChanged.name = habitText.text ?? ""
            habitChanged.date = timePicker.date
            habitChanged.color = circleColorButton.backgroundColor ?? .clear
        } else {
        
        let newHabit = Habit(name: habitText.text ?? "Название", date: timePicker.date, color: (circleColorButton.backgroundColor ?? UIColor(named: "Purple"))!)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func deleteHabitAlert() {
        if habit != nil {
            let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(String(describing: habit!.name))?", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            let confirm = UIAlertAction(title: "Удалить", style: .default, handler: { (action: UIAlertAction) in
                self.deleteHabit()
                let habitsViewController = HabitsViewController()
                self.navigationController?.pushViewController(habitsViewController, animated: true)
                
            })
            alertController.addAction(cancel)
            alertController.addAction(confirm)
            self.present(alertController, animated: true, completion: nil)
        } else {
            return
        }
    
    }
    
    func deleteHabit() {
        HabitsStore.shared.habits.removeAll {$0 == self.habit }
    }

    
    
    @objc func openColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = circleColorButton.backgroundColor!
        colorPicker.title = "Choose color"
        present(colorPicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelBarButtonPressed))
        navigationItem.leftBarButtonItem = cancelButton
        cancelButton.tintColor = UIColor(named: "Purple")
        
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveBarButtonPressed))
        navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = UIColor(named: "Purple")
        
        
        setupViews()
        
        if let habitChange = habit {
            navigationItem.title = "Править"
            habitText.text = habit?.name
            circleColorButton.backgroundColor = habitChange.color
            timePicker.date = habitChange.date
        }
        else {
    
            navigationItem.title = "Создать"
            habitDeleteButton.isHidden = true
        }
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(habitView)
        habitView.addSubview(habitNameLabel)
        habitView.addSubview(habitText)
        habitView.addSubview(colorLabel)
        habitView.addSubview(circleColorButton)
        habitView.addSubview(timeLabel)
        habitView.addSubview(timeText)
        habitView.addSubview(timePicker)
        habitView.addSubview(habitDeleteButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        habitView.translatesAutoresizingMaskIntoConstraints = false
        habitView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        habitView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        habitView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        habitView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        habitNameLabel.translatesAutoresizingMaskIntoConstraints = false
        habitNameLabel.topAnchor.constraint(equalTo: habitView.topAnchor, constant: 21).isActive = true
        habitNameLabel.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: CGFloat(sideIndent)).isActive = true
        habitNameLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        habitNameLabel.heightAnchor.constraint(equalToConstant: CGFloat(heightIndent)).isActive = true
      
        habitText.translatesAutoresizingMaskIntoConstraints = false
        habitText.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: CGFloat(smallIndent)).isActive = true
        habitText.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: CGFloat(sideIndent)).isActive = true
        habitText.widthAnchor.constraint(equalToConstant: 295).isActive = true
        habitText.heightAnchor.constraint(equalToConstant: 22).isActive = true
        habitText.delegate = self
        
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.topAnchor.constraint(equalTo: habitText.bottomAnchor, constant: CGFloat(indent)).isActive = true
        colorLabel.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: CGFloat(sideIndent)).isActive = true
        colorLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        colorLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        circleColorButton.translatesAutoresizingMaskIntoConstraints = false
        circleColorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: CGFloat(smallIndent)).isActive = true
        circleColorButton.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: CGFloat(sideIndent)).isActive = true
        circleColorButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        circleColorButton.heightAnchor.constraint(equalTo: circleColorButton.widthAnchor).isActive = true
        circleColorButton.addTarget(self, action: #selector(openColorPicker), for: .touchUpInside)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: circleColorButton.bottomAnchor, constant: CGFloat(indent)).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: CGFloat(sideIndent)).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        timeText.translatesAutoresizingMaskIntoConstraints = false
        timeText.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: CGFloat(smallIndent)).isActive = true
        timeText.leadingAnchor.constraint(equalTo: habitView.leadingAnchor, constant: CGFloat(sideIndent)).isActive = true
        timeText.widthAnchor.constraint(equalToConstant: 215).isActive = true
        timeText.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.topAnchor.constraint(equalTo: timeText.bottomAnchor, constant: CGFloat(indent)).isActive = true
        timePicker.leadingAnchor.constraint(equalTo: habitView.leadingAnchor).isActive = true
        timePicker.trailingAnchor.constraint(equalTo: habitView.trailingAnchor).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 216).isActive = true
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
    
        
        habitDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        habitDeleteButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 219).isActive = true
        habitDeleteButton.bottomAnchor.constraint(equalTo: habitView.bottomAnchor, constant: -CGFloat(heightIndent)).isActive = true
        habitDeleteButton.centerXAnchor.constraint(equalTo: habitView.centerXAnchor).isActive = true
        habitDeleteButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        habitDeleteButton.addTarget(self, action: #selector(deleteHabitAlert), for: .touchUpInside)

        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
}


extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.circleColorButton.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("ColorPicker dismissed")
    }
    
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

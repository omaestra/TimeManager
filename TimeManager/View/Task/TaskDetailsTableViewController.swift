//
//  TaskDetailsTableViewController.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 10/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class TaskDetailsTableViewController: UITableViewController {

    @IBOutlet weak var dueDateValueLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    
    @IBOutlet weak var pomodorosPickerView: UIPickerView!
    @IBOutlet weak var pomodorosValueLabel: UILabel!
    
    @IBOutlet weak var taskNotesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dueDatePickerView.isHidden = true
        pomodorosPickerView.isHidden = true
        
        pomodorosPickerView.dataSource = self
        pomodorosPickerView.delegate = self
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let expandedCellHeight: CGFloat = 200
        
        switch indexPath {
        case [1, 1]:
            return pomodorosPickerView.isHidden ? 0 : expandedCellHeight
        case [1, 3]:
            return dueDatePickerView.isHidden ? 0 : expandedCellHeight
        default:
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        case [1, 0]:
            pomodorosPickerView.isHidden = !pomodorosPickerView.isHidden
            dueDatePickerView.isHidden = true
            
            dueDateValueLabel.textColor = dueDatePickerView.isHidden ? .black : tableView.tintColor
        case [1, 2]:
            pomodorosPickerView.isHidden = true
            dueDatePickerView.isHidden = !dueDatePickerView.isHidden
            
            pomodorosValueLabel.textColor = dueDatePickerView.isHidden ? .black : tableView.tintColor
        default:
            pomodorosPickerView.isHidden = true
            dueDatePickerView.isHidden = true
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TaskDetailsTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let stringArray = (1...1000).map({ String($0) })
        return stringArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let stringArray = (1...1000).map({ String($0) })
        return stringArray[row]
    }
}

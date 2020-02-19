//
//  TasksTableViewController.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 10/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    lazy var newSessionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Start session", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 10.0
        
        button.addTarget(self, action: #selector(handleNewSession(_:)), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationController?.view.addSubview(newSessionButton)
//        newSessionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15.0).isActive = true
//        newSessionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 15.0).isActive = true
//
//        newSessionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 24.0).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        newSessionButton.clipsToBounds = true
        NSLayoutConstraint.activate([
            newSessionButton.leadingAnchor.constraint(equalTo: self.navigationController!.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            newSessionButton.trailingAnchor.constraint(equalTo: self.navigationController!.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            newSessionButton.bottomAnchor.constraint(equalTo: self.navigationController!.view.bottomAnchor, constant: -100),
            newSessionButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    @objc func handleNewSession(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "WorkSession", bundle: nil)
        guard let destination = storyboard.instantiateInitialViewController() else { return }
        guard let workSessionViewController = (destination as? UINavigationController)?.viewControllers.first as? WorkSessionViewController else { return }
        workSessionViewController.presenter = WorkSessionPresenter()
        workSessionViewController.delegate = self
        
        self.present(destination, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToTasksViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

}

extension TasksTableViewController: WorkSessionDelegate {
    func sessionDidEnd() {
        
    }
    
    func sessionCancelled() {
        
    }
}

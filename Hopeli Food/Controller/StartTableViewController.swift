//
//  StartTableViewController.swift
//  Hopeli Food
//
//  Created by Paul Hofer on 01.09.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit
import RealmSwift

class StartTableViewController: SwipeTableViewController {

    let realm = try! Realm()
    var user: Results<User>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    

    // MARK: - Table view data source

    //    Mark: - Tabel View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = user?[indexPath.row].userName ?? "add a User"
        //cell.cellImage.image = UIImage(data: user?[indexPath.row].userImage as! Data)
        
        return cell
    }
    
//     MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToUser", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! UserTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedUser = user?[indexPath.row]
        }
        
    }
    
    
    //    MARK: - Data Model Manipulation
    func saveData(user: User) {
        do {
            try realm.write {
                realm.add(user)
            }
        }catch {
            print("Couldn´t Save Category: \(error)")
        }
         self.tableView.reloadData()
    }

    func loadData () {
        user = realm.objects(User.self)
    }
    
    //Mark: - Delete Data from Swip
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let userDelete = self.user?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(userDelete)
                }
            }catch {
                print("Error while deleting \(error)")
            }
        }
        
    }
    
    //    MARK: - Add User
    
    @IBAction func addUserButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield: UITextField = UITextField()
        let alert = UIAlertController(title: "New User", message: "Add your Account", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add User", style: .default) { (action) in
            let newUser = User()
            newUser.userName = textfield.text!
            newUser.userId = self.user?.count ?? 0 + 1
            
            let image = UIImage(named: "user-default-image")
            newUser.userImage = NSData(data: UIImagePNGRepresentation(image!)!)
            
            self.saveData(user: newUser)
           
            
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create your Account"
            textfield = alertTextfield
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}

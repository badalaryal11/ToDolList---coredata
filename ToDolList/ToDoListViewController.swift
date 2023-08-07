//
//  ViewController.swift
//  ToDolList
//
//  Created by Badal  Aryal on 03/08/2023.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [""]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
//        if let itemArray = defaults.array(forKey: "TodoListArray") as? [String]{
//            itemArray = items
//        }
             // cannot
        // code to retrive the data from the to do list array.
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - TableViewDataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)// current indexpath which the tableview is looking  to populate
        cell.textLabel?.text = itemArray[indexPath.row] //cell populated with text for current row
        return cell
        
       
    }
    
    // MARK: - TableViewDelegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {// tells a delegate that a specified a row is now selected
        print(itemArray[indexPath.row])
        
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }  // == for checking
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            // what will happen once the user clicks the Add item button on the UIAlert
//            print("Add Item Pressed")
//            print(textField.text)
            self.itemArray.append(textField.text!) // textfield is never going to be equal to nil so unwrap it
           // self.itemArray.append(textField.text ?? "New Item") // self is used becouse it helps to tell the compiler explicitly itemArray is in the class
            self.defaults.set(self.itemArray, forKey: "TodoListArray")// inside a closure so self
            self.tableView.reloadData()// to put the new item in a tableview
            
            //self.defaults.set(UserDefaults, forKey: "TodoListArray")
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add a ToDo Item"
           textField = alertTextField
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    

}


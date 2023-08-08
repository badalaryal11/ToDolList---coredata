//
//  ViewController.swift
//  ToDolList
//
//  Created by Badal  Aryal on 03/08/2023.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = [Item]()
    
    //let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // create an array of itemObjects
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        
        //print(dataFilePath)
       
//        let newItem = Item()
//        newItem.title = "Go Shopping"
//        newItem.done = true
//        itemArray.append(newItem)
//
////      if let items = defaults.array(forKey: "TodoListArray") as? [String]{
////            itemArray = items
////        }
//             // code to retrive the data from the to do list array.
//        let newItem2 = Item()
//        newItem.title = "Go Shopping"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem.title = "Go Shopping"
//        itemArray.append(newItem3)
            loadItems()
        
        //itemArray.append(newItem3)
//        if let items = defaults.array(forKey: "TodoListArray") as? [item]{
//            itemArray = items
//        }
        
    }
    
    // MARK: - TableViewDataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       print("cellForRowAtIndexPathCalled")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)// current indexpath which the tableview is looking  to populate
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title//cell populated with text for current row
        // ternary operator
        //value = condition ? ValuIfTrue : ValueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
        
       
    }
    
    // MARK: - TableViewDelegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {// tells a delegate that a specified a row is now selected
        // print(itemArray[indexPath.row])
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//
         
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        //toggle the checkmark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//
//        }else{
//            itemArray[indexPath.row].done = false
//        }
//
//        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }  // == for checking
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        saveItems()
        
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
           
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem) // textfield is never going to be equal to nil so unwrap it
           // self.itemArray.append(textField.text ?? "New Item") // self is used becouse it helps to tell the compiler explicitly itemArray is in the class
           
            //self.defaults.set(UserDefaults, forKey: "TodoListArray")
            self.saveItems()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add a ToDo Item"
            textField = alertTextField
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - ModelManipulationMethods
    
    func saveItems(){
        //let encoder = PropertyListEncoder()
//        do{
//            let data = try encoder.encode(itemArray)
//            try data.write (to: dataFilePath!)
//        } catch{
//            print("Error encoding item array, \(error)")
//
//        }
        do{
           try context.save()
        }catch{
            print("Error Saving Context \(error)")
        }
        
        
       // self.defaults.set(self.itemArray, forKey: "TodoListArray")// inside a closure so self
        self.tableView.reloadData()// to put the new item in a tableview
        
        
    }
    
//    func loadItems(){
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do{
//                itemArray = try decoder.decode([Item].self, from: data)
//            }catch{
//                print("Error decoding item array, \(error)")
//            }
//
//        }
//    }
    // Reading Data from CoreData
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
           itemArray = try context.fetch(request)
        }catch{
            print("Error fetching request from context \(error)")
        }
    }
}


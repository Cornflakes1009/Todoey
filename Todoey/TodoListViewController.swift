//
//  ViewController.swift
//  Todoey
//
//  Created by Harold on 8/4/18.
//  Copyright © 2018 harold. All rights reserved.
//

// How to add in a navigation bar: select main.storyboard > Editor > Embed in > Navigation Bar for top navbar or Tab Bar Controller for bottom navbar

// checkmark is made by clicking on the prototype cell in he Main.storyboard structure (not clicking the Content View) and then clicking Checkmark under Accessories in the attributes inspector

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    // creating our own plist file
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    let defaults = UserDefaults.standard // setting a constandt equal to UserDefaults.standard so can run method calls.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(dataFilePath!)
        
        // checking if TodoListArray exists and then setting the items array as that value - this makes the app use the user default's saved data
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        let newItem = Item()
        
//        newItem.title = "find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "buy waffles"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "destroy dimigorgon"
//        itemArray.append(newItem3)
        
        loadItems()
    }
    
    
    //Mark - Tableview Datasource Methods
    
    // method for determining the number of cells to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title
        
        // ternary operator explained:  if item.done is equal to true, set the cell.accessoryType to a checkmark. If it's false, set it to none.
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods (called a pragma mark)
    // tells the delegate that the specified row is now selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row) // this will print the number of the cell that was clicked

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            // method for removing accessory if checkmark is already on it and you click it again
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            // method for adding checkmarks to each cell
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true) // method makes the selected cell flash gray and goes back to default color
        
        
        
    }
    
    //Mark - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField() // initializing a UITextField so it can be accessed in all of the below closures
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // what will happen once the user clicks the Add Item button on the UIAlert
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            // method for adding to nsuserdefaults
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems() {
        // this is a new object of type PropertyListEncoder
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array, \(error)")
        }
        
        self.tableView.reloadData() // reloads the tableView with the updated data
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error coding is \(error)")
            }
        }
    }
}















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

    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Mark - Tableview Datasource Methods
    
    // method for determining the number of cells to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods (called a pragma mark)
    // tells the delegate that the specified row is now selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row) // this will print the number of the cell that was clicked
        print(itemArray[indexPath.row])

        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            // method for removing accessory if checkmark is already on it and you click it again
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            // method for adding checkmarks to each cell
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true) // method makes the selected cell flash gray and goes back to default color
        
        
    }


}


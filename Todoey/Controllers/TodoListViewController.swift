//
//  ViewController.swift
//  Todoey
//
//  Created by Nataly Safronova on 25/02/2019.
//  Copyright © 2019 Nataly Safronova. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Купить молоко"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Cделать уборку"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Позвонить маме"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            
            itemArray = items
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark: .none
        
        
        return cell
    }
    
 //MARK Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
 
    
    //MARK Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // Что будет после нажатия на кнопку Add Item на нашем UIAlert
            
            // добалвяем в массив itemArray новый item, вносимый пользователем
           
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // Обновляем tableView, чтобы отразить внесенный пользователем новый item
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true,completion: nil)
        
    
    }
    
    
    
    
    
}


//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData


class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
//                                                in: .userDomainMask).first?.appendingPathComponent("items.plist")
//
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadItems()
    }


    // MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark :  .none
        
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

        
        itemArray[indexPath.row].done =  !itemArray[indexPath.row].done
        
        saveItems()

        //tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    
        
    }
    
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // something happens here when we click
            
           
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveItems()
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //self.tableView.reloadData()
            
            //print(textField.text as Any)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            //print(alertTextField)
           // print("Ta da!")
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK - Model Manipulation Methods
    func saveItems(){
        //let encoder = PropertyListEncoder()
        
        do {
            try context.save()
        } catch {
            print("Error saving item, \(error)")
        }
    
        self.tableView.reloadData()
    }
    
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       
        do {
           itemArray = try context.fetch(request)
        } catch {
            print("Error fetching Items data \(error)")
        }
    }
}


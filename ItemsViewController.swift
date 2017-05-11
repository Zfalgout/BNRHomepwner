//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Zack Falgout on 5/6/17.
//  Copyright © 2017 Zack Falgout. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController{
    var itemStore: ItemStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create an instance of UITableViewCell, with defaultappearance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        if indexPath.row < itemStore.allItems.count{
            //Get a recycled cell if one exists.  If not, create one.
            //let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
            
            //Set the text on the cell with the description of the item
            //that is at the nth index of items, where n = row this cell will appear in on the tableview
            let item = itemStore.allItems[indexPath.row]
        
            //cell.textLabel?.text = item.name
            //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            
            //Configure the cell with the Item
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "\(item.valueInDollars)"
            
            //Code for the Bronze Challenge
            if let valueOfValueLabel = Int(cell.valueLabel.text!){
                if valueOfValueLabel < 50 {
                    //If the value is less than fifty, change the UIColor to red
                    cell.valueLabel.textColor = UIColor.red
                } else {
                    //Else it is greater than or equal to 50, change it green
                    cell.valueLabel.textColor = UIColor.green
                }
            }
            
            
            return cell
        } else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell_NMI")
            cell.textLabel?.text = "No more Items!"
            cell.isUserInteractionEnabled = false
            cell.textLabel?.isEnabled = false
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row >= itemStore.allItems.count){
            return false
        }
        return true
    }
    
    //Loading methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
    }
    
    //Chapter 11 code
    @IBAction func addNewItem(_ sender: UIButton){
        //Make a new index path for the 0th section, last row.
        //        let lastRow = tableView.numberOfRows(inSection: 0)
        //        let indexPath = IndexPath(row: lastRow, section: 0)
        //
        //        //Insert this new row into the table
        //        tableView.insertRows(at: [indexPath], with: .automatic)
        
        //Create a new item and add it to the stroe
        let newItem = itemStore.createItem()
        
        //Figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            
            //Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton){
        //If you are current in editing mode:
        if isEditing{
            //Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            //Turn off editing mode
            setEditing(false, animated: true)
        } else {
            //Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            //Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        //If the table view is asking to commit a delete command...
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            //Changed "Delete" to "Remove" for bronze challenge.
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: { (action) -> Void in
                
                //print("The number of items in the itemStore is:  \(self.itemStore.allItems.count)")
                //Remove item from the store
                self.itemStore.removeItem(item)
                
                //Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
        
            ac.addAction(deleteAction)
                
            //Present the alert controller
            present(ac, animated: true, completion: nil)
            
            //Remove the item from the store
            itemStore.removeItem(item)
            
            //Also remove that row from the table view with an animation
            //tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        
        if destinationIndexPath.row < itemStore.allItems.count{
            //Update the model
            print("\(destinationIndexPath.row)  and    \(itemStore.allItems.count)")
            itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        } else if destinationIndexPath.row >= itemStore.allItems.count{
            print("\(destinationIndexPath.row)  and    \(itemStore.allItems.count)   and \(sourceIndexPath.row)")
            
            for item in itemStore.allItems{
                print(item.name)
            }
            
            //tableView.cellForRow(at: sourceIndexPath)
            //tableView.deselectRow(at: sourceIndexPath, animated: true)
            //tableView.endUpdates()
            tableView.reloadData()
        }
    }
    
    
    
    //Chapter 13
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        //If the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showItem"?:
            //Figure out which row wsa just tapped
            if let row = tableView.indexPathForSelectedRow?.row{
                //Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            print("The segue identifier is: \(String(describing: segue.identifier))")
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    //Chapter 14
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

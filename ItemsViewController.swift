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
    
    @IBAction func addNewItem(_ sender: UIButton){
        
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create an instance of UITableViewCell, with defaultappearance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        //Get a recycled cell if one exists.  If not, create one.
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        //Set the text on the cell with the description of the item
        //that is at the nth index of items, where n = row this cell will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    //Loading methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
}

//
//  ItemStore.swift
//  Homepwner
//
//  Created by Zack Falgout on 5/6/17.
//  Copyright © 2017 Zack Falgout. All rights reserved.
//

import UIKit

class ItemStore{
    var allItems = [Item]()
    
    
    @discardableResult func createItem() -> Item{
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    //Chapter 11
    func removeItem(_ item: Item)  {
        if let index = allItems.index(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        let count = allItems.count
        if (fromIndex == toIndex || toIndex >= count){
            return
        }
        
        //Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        //Remove item from array
        allItems.remove(at: fromIndex)
        
        //Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}

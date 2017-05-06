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
    
    init(){
        for _ in 0..<5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item{
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
}

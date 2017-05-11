//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Zack Falgout on 5/10/17.
//  Copyright © 2017 Zack Falgout. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateCreatedField: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var serialTextField: UITextField!
    
    var item: Item!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("The item is: \(item.description)")
        nameTextField.text = item.name
        dateCreatedField.text = dateFormatter.string(from: item.dateCreated)
        valueTextField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        serialTextField.text = item.serialNumber
    }
}

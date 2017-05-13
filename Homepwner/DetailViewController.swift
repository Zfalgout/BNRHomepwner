//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Zack Falgout on 5/10/17.
//  Copyright © 2017 Zack Falgout. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var nameTextField: ResponderSubclass!
    @IBOutlet weak var dateCreatedField: UILabel!
    @IBOutlet weak var valueTextField: ResponderSubclass!
    @IBOutlet weak var serialTextField: ResponderSubclass!
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
//        if(nameTextField.isFirstResponder){
//            _ = nameTextField.resignFirstResponder()
//        }else if(serialTextField.isFirstResponder){
//           _ = serialTextField.resignFirstResponder()
//        }else if(valueTextField.isFirstResponder){
//            _ = valueTextField.resignFirstResponder()
//        }
        
        //view.endEditing should call resignFirstResponder on the view that is a first responder.
        //All of my views are subclasses of UITextField and I've checked that each is the first responder
        //when clicked on.  For some reason this isn't firing off the overridden functions in the class
        //ResponderSubclass
        view.endEditing(true)
        print("backgroundTapped fired!")
    }
    
    var item: Item!{
        didSet{
            navigationItem.title = item.name
        }
    }
    
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
    
    //Chapter 14 code
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        //"Save" changes to the item.
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialTextField.text
        
        if let valueText = valueTextField.text, let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

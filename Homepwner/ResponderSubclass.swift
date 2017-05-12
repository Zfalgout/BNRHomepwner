//
//  ResponderSubclass.swift
//  Homepwner
//
//  Created by Zack Falgout on 5/12/17.
//  Copyright © 2017 Zack Falgout. All rights reserved.
//
// I realize now that "ResponderSubclass" is a poor name for this file.  Should have been
// "TextFieldSubclass".

import UIKit

class ResponderSubclass: UITextField{
    
    override func becomeFirstResponder() -> Bool {
        print("called the becomeFirstResponder overridden function")
        self.borderStyle = .none
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        print("called the resignFristResponder overridden function")
        self.borderStyle = .bezel
        
        return super.resignFirstResponder()
    }
}

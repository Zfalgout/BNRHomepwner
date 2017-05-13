//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Zack Falgout on 5/10/17.
//  Copyright © 2017 Zack Falgout. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var nameTextField: ResponderSubclass!
    @IBOutlet weak var dateCreatedField: UILabel!
    @IBOutlet weak var valueTextField: ResponderSubclass!
    @IBOutlet weak var serialTextField: ResponderSubclass!
    
    //Chapter 15 variables and functions associated with UI
    @IBOutlet var imageView: UIImageView!
    
    var imageStore: ImageStore!
    
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
        
        //Get the item key
        let key = item.itemKey
        
        //If there is an associated image with the item display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
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
    
    //Chapter 15 functions
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        //imagePicker.setEditing(true, animated: true)
        //If the device has a camera, take a picture; otherwise,
        //just pick a photo from the photo library.
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        //imagePicker.setEditing(true, animated: true)
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        //picker.setEditing(true, animated: true)
        
        //Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //picker.allowsEditing = true
        print("\(picker.allowsEditing)")
        
        //Store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        //Put that image on the screen in the image view
        imageView.image = image
        
        //Take image picker off the screen - you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
}

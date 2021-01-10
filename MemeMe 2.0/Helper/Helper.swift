//
//  Helper.swift
//  MemeMe 2.0
//
//  Created by user on 08/01/2021.
//

import UIKit

protocol Helper {
    
}

extension Helper{
    
    func configure(navigationItem: UINavigationItem, addMemeSelector: Selector){
        navigationItem.title  = "Sent Memes" // Screen title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: addMemeSelector)
    }
    
    /**
     Configure the top and bottom textField
     
     - Parameters:
            - textfield: Textfield whose attributes is to be changed
            - text:The default text
    */
    func configureTextField(_ textfield: UITextField, withText text: String){
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
           .foregroundColor: UIColor.white,
           .strokeColor: UIColor.black,
           .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .strokeWidth: -3.0,
        ]
        
        textfield.defaultTextAttributes = memeTextAttributes
        textfield.textAlignment = .center
        textfield.autocapitalizationType = .allCharacters
        textfield.text = text
    }
    
    func subscribeToKeyboardNotifications(showKeyboardSelector: Selector, hideKeyboardSelector: Selector){
        NotificationCenter.default.addObserver(self, selector: showKeyboardSelector, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: hideKeyboardSelector, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /**
     Get the height of the keyboard
     
     - Returns: A CGFloat which is the height of the keyboard
    */
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
   
}

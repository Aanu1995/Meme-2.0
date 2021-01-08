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
    
   
}

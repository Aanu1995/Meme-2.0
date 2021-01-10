//
//  Notification.swift
//  MemeMe 2.0
//
//  Created by user on 09/01/2021.
//
import  UIKit

class MemeNotification {
    
    static func notify (name: String){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: nil)
    }
}

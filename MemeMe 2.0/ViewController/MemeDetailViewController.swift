//
//  MemeDetailViewController.swift
//  MemeMe 2.0
//
//  Created by user on 08/01/2021.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    // MARK: Property
    
    static let identifier = "MemeDetailViewController"
    var meme: Meme!
    
    // MARK: IBOutlet
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let meme = meme {
            self.memeImage.image = meme.memedImage
        }
       
    }

}

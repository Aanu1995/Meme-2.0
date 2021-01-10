//
//  SentMemeTableViewCell.swift
//  MemeMe 2.0
//
//  Created by user on 09/01/2021.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "SentMemeTableViewCell"
    
   // MARK: IBOutlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rowImage: UIImageView!
    
    func configure(with model: Meme){
        self.label.text = model.topText + " ... " + model.bottomText
        self.rowImage.image = model.memedImage
        self.rowImage.contentMode = .scaleAspectFill
        self.rowImage.backgroundColor = .gray
    }
    
}

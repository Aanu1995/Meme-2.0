//
//  SentMemeCollectionViewCell.swift
//  MemeMe 2.0
//
//  Created by user on 09/01/2021.
//

import UIKit

class SentMemeCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let identifier = "SentMemeCollectionViewCell"
    
    // MARK: IBOutets
    
    @IBOutlet weak var rowImage: UIImageView!
    
    func configure(with model: Meme){
       self.rowImage.contentMode = .scaleAspectFill
       self.rowImage.backgroundColor = .gray
       self.rowImage.image = model.memedImage
    }
}



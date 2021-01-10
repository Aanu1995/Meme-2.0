//
//  MemeCollectionViewController.swift
//  MemeMe 2.0
//
//  Created by user on 08/01/2021.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout, Helper {
    
    // MARK: Prperties
    
    private var allSentMemes = [Meme]()
    static let notificationName = "MemeCollection"

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure(navigationItem: self.navigationItem, addMemeSelector: #selector(createMeme))
        
        self.getMemes()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCollection), name: NSNotification.Name(rawValue: MemeCollectionViewController.notificationName), object: nil)
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func refreshCollection(){
        self.getMemes()
       collectionView.reloadData()
    }
    
    @objc func createMeme(){
        let controller = storyboard?.instantiateViewController(identifier:
        MemeEditorViewController.identifier) as! MemeEditorViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
     }
    
    // get the list of sent memes
    func getMemes(){
        allSentMemes.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        for meme in appDelegate.memes{
            allSentMemes.append(meme)
        }
    }
}


extension MemeCollectionViewController{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSentMemes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let controller = self.storyboard?.instantiateViewController(identifier: MemeDetailViewController.identifier) as! MemeDetailViewController
        
        controller.meme = allSentMemes[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SentMemeCollectionViewCell.identifier, for: indexPath) as! SentMemeCollectionViewCell
       cell.configure(with: allSentMemes[indexPath.row])
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3.0) - 2
        
        return CGSize(width: width, height: width)
    }
    
    // Column Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(6)
    }
}

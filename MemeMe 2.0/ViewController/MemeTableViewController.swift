//
//  MemeTableViewController.swift
//  MemeMe 2.0
//
//  Created by user on 08/01/2021.
//

import UIKit

class MemeTableViewController: UIViewController, Helper {
    
    // MARK: Prperties
    
    private var allSentMemes = [Meme]()
    static let notificationName = "MemeTable"
    
    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure(navigationItem: self.navigationItem, addMemeSelector: #selector(createMeme))
        
        //self.getMemes()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: NSNotification.Name(rawValue: MemeTableViewController.notificationName), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func refreshTable(){
        getMemes()
        tableView.reloadData()
    }
    
    @objc func createMeme(){
        let controller = storyboard?.instantiateViewController(identifier:
        MemeEditorViewController.identifier) as! MemeEditorViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
     }
    
    func getMemes(){
        allSentMemes.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        for meme in appDelegate.memes{
            allSentMemes.append(meme)
        }
    }
}



extension MemeTableViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = self.storyboard?.instantiateViewController(identifier: MemeDetailViewController.identifier) as! MemeDetailViewController
        
        controller.meme = allSentMemes[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSentMemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SentMemeTableViewCell.identifier, for: indexPath) as! SentMemeTableViewCell
        
        let meme = allSentMemes[indexPath.row]
        cell.configure(with: meme)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.width * 0.42)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = deleteRowInTable(at: indexPath)
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // delete cell function
    func deleteRowInTable(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.allSentMemes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes.remove(at: indexPath.row)
            // notify Collection Screen to reload the collectionView
            MemeNotification.notify(name: MemeCollectionViewController.notificationName)
            completion(true)
        }
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red
        
        return action
    }

}


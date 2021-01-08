//
//  MemeTableViewController.swift
//  MemeMe 2.0
//
//  Created by user on 08/01/2021.
//

import UIKit

class MemeTableViewController: UIViewController, Helper {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure(navigationItem: self.navigationItem, addMemeSelector: #selector(createMeme))
    }

    @objc func createMeme(){
        let controller = storyboard?.instantiateViewController(identifier: "MemeEditorViewController") as! MemeEditorViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
     }
    
    
}

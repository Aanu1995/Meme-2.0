//
//  MemeEditorViewController.swift
//  Meme
//
//  Created by user on 02/01/2021.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Helper{
    
    // MARK: IBOutlets

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    

    
    // MARK: Property
    static let identifier = "MemeEditorViewController"
    let topPlaceholderText:String = "TOP"
    let bottomPlaceholderText: String = "BOTTOM"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        cameraBarButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // disable share button because image is nil
        shareBarButton.isEnabled = false
        
        configureTextField(topTextField, withText: topPlaceholderText)
        
        configureTextField(bottomTextField, withText: bottomPlaceholderText)
        
        subscribeToKeyboardNotifications(showKeyboardSelector: #selector(keyboardWillShow(_:)), hideKeyboardSelector: #selector(keyboardWillHide))
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage{
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // enabled the share button
            shareBarButton.isEnabled = true;
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: IBActions

    @IBAction func pickImageFromAlbum(_ sender: Any) {
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    @IBAction func pickImageUsingCamera(_ sender: Any) {
        presentImagePickerWith(sourceType: .camera)
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let memedImage = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            
            if completed && error == nil {
                // save the meme object
                self.save(memedImage)
                
                // notify to update
                MemeNotification.notify(name: MemeTableViewController.notificationName)
                MemeNotification.notify(name: MemeCollectionViewController.notificationName)
                
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        self.present(controller, animated: true, completion: nil)
        
        // for ipad
        if let popOver = controller.popoverPresentationController {
          popOver.sourceView = self.view
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillHide(){
        view.frame.origin.y = 0.0
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        if bottomTextField.isEditing{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func hideTopAndBottomBars(hide: Bool) {
        topToolBar.isHidden = hide
        bottomToolBar.isHidden = hide
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        
        controller.delegate = self
       // controller.allowsEditing = true
        controller.sourceType = sourceType
        
        present(controller, animated: true, completion: nil)
    }
    
    /**
     Create a memed image
     
     - Returns: A new UIImage from original image and top and bottom texts
    */
    func generateMemedImage() -> UIImage {
        hideTopAndBottomBars(hide:true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideTopAndBottomBars(hide:false)

        return memedImage
    }
    
    /**
     Save a meme
     
     - Parameter memedImage: image generated after combining original image and texts
    */
    func save(_ memedImage: UIImage) {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes.append(meme)
    }
}


extension MemeEditorViewController{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.text == topPlaceholderText || textField.text == bottomPlaceholderText){
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



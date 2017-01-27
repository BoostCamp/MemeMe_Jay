//
//  MemeUpdateViewController.swift
//  MeMeApp_1.0
//
//  Created by 한정 on 2017. 1. 26..
//  Copyright © 2017년 한정. All rights reserved.
//

import UIKit

class MemeUpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    var meme:Meme!
    var newMemedImage:UIImage!
    
    // MARK : properties
    @IBOutlet weak var ImagePickView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BottomTextField: UITextField!
    @IBOutlet weak var Toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    @IBAction func TouchBackButton(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func TouchShareButton(_ sender: Any) {
        newMemedImage = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems: [newMemedImage], applicationActivities: nil)
        
        controller.popoverPresentationController?.sourceView = view
        present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = {
            (activityType, complete, returnedItems, activityError ) in
            if complete {
                print("complete")
                self.save()
                let _ = self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBAction func TouchCameraButton(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func TouchAlbumButton(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        present(pickerController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            ImagePickView.image = image
            shareButton.isEnabled = true
            TopTextField.isEnabled = true
            BottomTextField.isEnabled = true
        } else{
            print("album image pick error")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    let TextAttribute = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName: UIFont(name: "Impact", size: 37)!,
        NSStrokeWidthAttributeName: -5
        ] as [String : Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopTextField.delegate = self
        BottomTextField.delegate = self
        ImagePickView.image = meme.originalImage
        TopTextField.text = meme.topText
        BottomTextField.text = meme.bottomText
        TopTextField.defaultTextAttributes = TextAttribute
        BottomTextField.defaultTextAttributes = TextAttribute
        TopTextField.textAlignment = .center
        BottomTextField.textAlignment = .center
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == BottomTextField {
            unsubscribeFromKeyboardNotifications()
        }
        return true
    }
    
    // MARK : keyboard hide, show appropriate height
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == BottomTextField {
            subscribeToKeyboardNotifications()
        }
    }
    func keyboardWillShow(_ notification:Notification){
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            print(self.view.frame.origin.y)
        }
    }
    func keyboardWillHide(_ notification:Notification){
        if self.view.frame.origin.y != 0{
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK : Save function
    func save() {
        let meme = Meme(topText: TopTextField.text!, bottomText: BottomTextField.text!, originalImage: ImagePickView.image!, memedImage: newMemedImage)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        Toolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        Toolbar.isHidden = false
        
        return memedImage
    }

    
}

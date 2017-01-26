//
//  MemeMakeViewController.swift
//  MeMeApp_1.0
//
//  Created by 한정 on 2017. 1. 18..
//  Copyright © 2017년 한정. All rights reserved.
//

import UIKit

class MemeMakeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    
    // MARK : properties
    @IBOutlet weak var ImagePickView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BottomTextField: UITextField!
    @IBOutlet weak var Toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var memedImage:UIImage!

    
    @IBAction func TouchBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        present(pickerController, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
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
        shareButton.isEnabled = false
        
        ImagePickView.contentMode = UIViewContentMode.scaleAspectFit
        
        TopTextField.delegate = self
        BottomTextField.delegate = self
        TopTextField.text = "TOP"
        BottomTextField.text = "BOTTOM"
        
        TopTextField.defaultTextAttributes = TextAttribute
        BottomTextField.defaultTextAttributes = TextAttribute
        
        TopTextField.textAlignment = .center
        BottomTextField.textAlignment = .center
        
        TopTextField.isEnabled = false
        BottomTextField.isEnabled = false
    }
    
    // MARK : textField First select clear function
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
        else if textField.text!.isEmpty{
            textField.text = "채우세요"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK : keyboard hide, show appropriate height
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func findFirstResponder() -> UIResponder? {
        for v in self.view.subviews {
            if v.isFirstResponder {
                return (v as UIResponder)
            }
        }
        return nil
    }
    
    func getKeyboardRect(_ notification:Notification) -> CGRect {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue
    }
    
    func keyboardWillShow(_ notification:Notification) {
        let keyboardRect = getKeyboardRect(notification)
        let textField = findFirstResponder() as! UITextField
        if keyboardRect.contains(textField.frame.origin) { // bottom text field
            view.frame.origin.y = 0 - getKeyboardRect(notification).height
        }
    }
    
    func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK : shared function
    @IBAction func shareImage(_ sender: Any) {
        memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        controller.popoverPresentationController?.sourceView = view
        present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = {
            (activityType, complete, returnedItems, activityError ) in
            if complete {
                print("complete")
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK : Save function
    func save() {
        let meme = Meme(topText: TopTextField.text!, bottomText: BottomTextField.text!, originalImage: ImagePickView.image!, memedImage: memedImage)
        
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





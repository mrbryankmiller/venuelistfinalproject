//
//  SIgnUPTableViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/17/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit

class SIgnUPTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
  
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    let networkingService = NetworkingService()
    
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    
        
    
        
    }
    
    ///return Keyboard
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == usernameTextField{
            usernameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
            
        }
        
        if textField == emailTextField{
            emailTextField.resignFirstResponder()
            
            passwordTextField.becomeFirstResponder()
        }
        
        if textField == passwordTextField{
            passwordTextField.resignFirstResponder()
            
            print("resign")
        }
        
        return true
    }
    
    
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8)
        
        networkingService.signUp(emailTextField.text!, username: usernameTextField.text! , password: passwordTextField.text!, data: data!)
        
        let alert = UIAlertController(title:"Welcome To VenueList", message:"You have successfully Signed Up!", preferredStyle:UIAlertControllerStyle.Alert)
        
        
        func someHandler(alert: UIAlertAction!) {
            // Do something...
            print("Ok Button has been clicked")
            self.performSegueWithIdentifier("returnBack", sender: nil)

        }
        
    

        let alertAction = UIAlertAction(title: "OK",style:UIAlertActionStyle.Default, handler:someHandler);
            
                alert.addAction(alertAction);
        
        self.presentViewController(alert, animated: true, completion:  {
                    print("Got it. Presentation complete")
                    
                })
        
        
       //go to another view controller
        
//      let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewControllerWithIdentifier("Login")
//       presentViewController(vc, animated: true, completion: nil)
        
       
    }
    
    @IBAction func choosePicture(sender: AnyObject) {
        let pickerController  = UIImagePickerController()
        pickerController.delegate = self
        
        //crop and zoom in picture
        pickerController.allowsEditing = true
        
        let alertContoller = UIAlertController(title: "Add a Photo", message: "Choose from", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) {(action) in pickerController.sourceType = .Camera
            self.presentViewController(pickerController, animated: true, completion: nil)
        }
            
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .Default) {(action) in pickerController.sourceType = .PhotoLibrary
                self.presentViewController(pickerController, animated: true, completion: nil)
        }
            
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .Default) {(action) in pickerController.sourceType = .SavedPhotosAlbum
                self.presentViewController(pickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
            
       alertContoller.addAction(cameraAction)
        alertContoller.addAction(photosLibraryAction)
        alertContoller.addAction(savedPhotosAction)
         alertContoller.addAction(cancelAction)
        
        presentViewController(alertContoller, animated: true, completion: nil)
    
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.userImageView.image = image
    }
    
}
//
//  SIgnUPTableViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/17/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit

class SIgnUPTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
  
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
    }
    
    

    
    
    
    @IBAction func signUpAction(sender: AnyObject) {
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
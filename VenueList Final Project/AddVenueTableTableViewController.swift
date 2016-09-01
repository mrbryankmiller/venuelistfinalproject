//
//  AddVenueTableTableViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/15/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase


class AddVenueTableTableViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

 
    @IBOutlet weak var venueImage: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    
    @IBOutlet weak var descriptionText: UITextView!
    
    
    @IBOutlet weak var locationTextField: UITextField!
    
    
    
    //@IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var occupancyTextfield: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    
   // @IBOutlet weak var contactTextField: UITextField!
    
    
    @IBOutlet weak var contactTextView: UITextView!
    
    var databaseRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference!{
        return FIRStorage.storage().reference()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set rounded border
        self.descriptionText.layer.borderWidth = 0.1
        self.descriptionText.layer.cornerRadius = 8
        
        
        self.addressTextView.layer.borderWidth = 0.1
        self.addressTextView.layer.cornerRadius = 8
        
        self.contactTextView.layer.borderWidth = 0.1
        self.contactTextView.layer.cornerRadius = 8

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    ///return Keyboards in order
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == titleTextField{
            titleTextField.resignFirstResponder()
            
            descriptionText.becomeFirstResponder()
        }
        
        if textField == descriptionText{
            descriptionText.resignFirstResponder()
            
            addressTextView.becomeFirstResponder()
        }
        
        if textField == addressTextView{
            addressTextView.resignFirstResponder()
            
            locationTextField.becomeFirstResponder()
        }
        
        if textField == locationTextField{
            locationTextField.resignFirstResponder()
            
            occupancyTextfield.becomeFirstResponder()
        }
            
            if textField == occupancyTextfield{
                occupancyTextfield.resignFirstResponder()
                
                priceTextField.becomeFirstResponder()
        }
        if textField == priceTextField{
            priceTextField.resignFirstResponder()
            
            contactTextView.becomeFirstResponder()
        }
        if textField == contactTextView{
            contactTextView.resignFirstResponder()

        
        
            
            print("resign")
        }
        
        return true
    }
    
    

    
    
    
    @IBAction func saveButtonAction(sender: AnyObject) {
        
//        var contactinfo = ""
//        
//        if let contact = contactTextField.text{
//            contactinfo = contact
//            
//        }else {
//            contactinfo = ""
//        }
//        
        
        
        let data = UIImageJPEGRepresentation(self.venueImage.image!, 0.5)
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        
        
        let postID = "\(FIRAuth.auth()!.currentUser!.uid)\(NSUUID().UUIDString)"
        let imagePath = "postVenueImage\(postID)/postPic.jpg"
        
        //save image
        storageRef.child(imagePath).putData(data!, metadata: metadata) { (metadata, error) in
            if error == nil {
                
                let postref = self.databaseRef.child("posts").childByAutoId()
                
                
                
                let post = venuePost(imageURL: String(metadata!.downloadURL()!), title: self.titleTextField.text!, address: self.addressTextView.text!, description: self.descriptionText.text!, occupancy: self.occupancyTextfield.text!, price: self.priceTextField.text!, contact: self.contactTextView.text!, location: self.locationTextField.text!, postId: postID)
                
            
                
                
               postref.setValue(post.toAnyObject())
                
            }else {
                print(error!.localizedDescription)
        
            }
        }
        
        // save button will take user to preview viewcontroller
        
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func chooseImage(sender: AnyObject) {
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
        self.venueImage.image = image
    }
    
    
}

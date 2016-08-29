//
//  MyProfileViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/22/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var emailTextFeild: UITextField!
    
    
    @IBOutlet weak var changePasswordTextField: UITextField!
    
    @IBOutlet weak var userImageView: CustomUiImageView!
    
    var urlImage : String!
    
    
    var databaseRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    
    
    var storageRef: FIRStorage!{
        return FIRStorage.storage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if FIRAuth.auth()?.currentUser == nil {
        
        
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            presentViewController(vc, animated: true, completion: nil)
        }
        
        else{
        
        databaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observeEventType(.Value, withBlock: { (snapshot) in
            dispatch_async(dispatch_get_main_queue(), {
                
                let user = User(snapshot:snapshot)
                self.usernameTextfield.text = user.username
                self.emailTextFeild.text = user.email
                let imageURL = String(user.photoURL)
                
                self.storageRef.referenceForURL(imageURL).dataWithMaxSize(1 * 1024 * 1024, completion: { (data,error ) in
                    if let error = error {
                        print(error.localizedDescription)
                    }else{
                        if let data = data {
                        self.userImageView.image = UIImage (data:data)
                        }
                    
                    }
                })
                
                
                
                
            
        
                
            })
                
                
        
            
            
            }) { (error) in
                print(error.localizedDescription)
            }
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LogOutAction(sender: AnyObject) {
        
        if FIRAuth.auth()?.currentUser != nil {
        
        do {
            
        try FIRAuth.auth()?.signOut()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            presentViewController(vc, animated: true, completion: nil)
            
        } catch let error as NSError {
            print (error.localizedDescription)
            }
        }
    }

}

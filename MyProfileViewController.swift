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
    
    @IBAction func updateEmail(sender: AnyObject) {

        if let user = FIRAuth.auth()?.currentUser {
            user.updateEmail(emailTextFeild.text!, completion: { (error) in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    let alertView = UIAlertView(title: "Update Email", message: "You have successfully Updated Your Email!", delegate: self, cancelButtonTitle: "OK, Thanks!")
                    alertView.show()
                }
            })
        }
        
    }
    
    
    @IBAction func updatePassword(sender: AnyObject) {
        if let user = FIRAuth.auth()?.currentUser {
            user.updateEmail(changePasswordTextField.text!, completion: { (error) in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    let alertView = UIAlertView(title: "Update Password", message: "You have successfully Updated Your Password!", delegate: self, cancelButtonTitle: "OK, Thanks!")
                    alertView.show()
                }
            })
        }
        
    }
    
    
    
    @IBAction func deleteAccount(sender: AnyObject) {
        
        let user = FIRAuth.auth()?.currentUser
      
        user?.deleteWithCompletion({ (error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                let alertView = UIAlertView(title: "Delete Account", message: "You have successfully Deleted Your Account!", delegate: self, cancelButtonTitle: "Sorry to See You Go!")
                alertView.show()
            }
        })
            
}
 // redirect annonymous user to login

    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    private func segueToLoginScreenForAnonymousUser() {
        
        let myCurrentUser = FIRAuth.auth()?.currentUser
        
        
        //FIRAuth.auth()?.currentUser?.anonymous
        if myCurrentUser!.anonymous {
            //my user is an anonymous user
            
            self.performSegueWithIdentifier("goToLogin", sender: nil)
            
            
            //self.navigationController?.performSegueWithIdentifier("goToLogin", sender: nil)
        }
        else{
            //my user is a regular user
        }

    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentUser = FIRAuth.auth()?.currentUser
        
        if currentUser!.anonymous {
            segueToLoginScreenForAnonymousUser()
            return
        }
        
        //status bar tint color 
        
         UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        
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
            
            print("User Logged out!")
        
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

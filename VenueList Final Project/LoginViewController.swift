//
//  LoginViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/15/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    let networkService = NetworkingService()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///return Keyboard 
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
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
    
    
    
    
    
    
    
    
    // reverses the current segue
    @IBAction func unwindToLogin(storyboard:UIStoryboardSegue){
        
        
    }
    
    @IBAction func loginAction(sender: AnyObject){
        networkService.signIn(emailTextField.text!, password: passwordTextField.text!)
        
        
        ///go to Home Screen 
        
       let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
        presentViewController(vc, animated: true, completion: nil)
       
    //alert when user signs in 
        
        
//        
//        let alert = UIAlertController(title:"Welcome To VenueList", message:"You have successfully Signed In!", preferredStyle:UIAlertControllerStyle.Alert)
//        
//        alert.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.Default, handler:nil)); self.presentViewController(alert, animated:true, completion:nil)
        
        
    }

}

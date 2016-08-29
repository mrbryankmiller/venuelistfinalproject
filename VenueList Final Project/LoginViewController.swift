//
//  LoginViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/15/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    

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
    
    
    // reverses the current segue
    @IBAction func unwindToLogin(storyboard:UIStoryboardSegue){
        
        
    }
    
    @IBAction func loginAction(sender: AnyObject){
        networkService.signIn(emailTextField.text!, password: passwordTextField.text!)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
        presentViewController(vc, animated: true, completion: nil)
        
        
    }

}

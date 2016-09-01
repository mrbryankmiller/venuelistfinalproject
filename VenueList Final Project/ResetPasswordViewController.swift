//
//  ResetPasswordViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/17/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit


class ResetPasswordViewController: UIViewController {
    
    let networkingService = NetworkingService()
    
    @IBOutlet weak var emailTextField: CustomTextfield!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    print("resign")
    
    textField.resignFirstResponder()
    return true
    
    
}


    @IBAction func resetPasswordAction(sender: AnyObject) {
        
      networkingService.resetPassword(emailTextField.text!)
    }
    
}

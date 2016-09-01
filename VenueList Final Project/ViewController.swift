//
//  ViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/15/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchVenueButton: CustomButton!
    
    
    @IBOutlet weak var ListVenueButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // sign in annonymous user 

    @IBAction func searchVenueAction(sender: AnyObject) {
        
        FIRAuth.auth()?.signInAnonymouslyWithCompletion({ (user, error) in
            if error != nil {
                print (error)
                return
            }
            print("User Signed in anonymously with udid:" + user!.uid)
        })
    }

       
    
}


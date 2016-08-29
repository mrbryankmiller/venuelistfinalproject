//
//  VenueDetailTableViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/25/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class VenueDetailTableViewController: UITableViewController {
    

    @IBOutlet weak var venueImageView: UIImageView!
    
    
    @IBOutlet weak var vdPriceLabel: UILabel!
    
    
    @IBOutlet weak var vdTitleLabel: UILabel!
    
    
    @IBOutlet weak var vdLocationLabel: UILabel!
    
    @IBOutlet weak var vdDescriptionTextView: UITextView!
    
    
    @IBOutlet weak var vdOccupancyLabel: UILabel!
    
    
    @IBOutlet weak var vdContactLabel: UILabel!
    
    var currentVenuePost :  venuePost!
        
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        vdTitleLabel.text = currentVenuePost.title
        vdPriceLabel.text = currentVenuePost.price
        
        vdLocationLabel.text = currentVenuePost.location
        
        
        vdDescriptionTextView.text = currentVenuePost.description
        
        vdOccupancyLabel.text = currentVenuePost.occupancy
        
        vdContactLabel.text = currentVenuePost.contact

        
        
        
        
        
        
        FIRStorage.storage().referenceForURL(currentVenuePost.imageURL).dataWithMaxSize(1 * 1024 * 1024) { (imagedata, error) in
            if error == nil {
                
                dispatch_async(dispatch_get_main_queue(), {
                    if let data = imagedata {
                        
                        self.venueImageView.image = UIImage(data: data)
                        
                    }
                })
                
                
                
            }else {
                print(error?.localizedDescription)
            }
        }
        
    }
    // MARK: - Table view data source


}

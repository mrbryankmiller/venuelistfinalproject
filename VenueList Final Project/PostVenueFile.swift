//
//  PostVenueFile.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/24/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

struct venuePost {
    
    
    var imageURL: String!
    var title: String!
    var description: String!
    var location:String!
    var occupancy:String!
    var price:String!
    var contact: String!
    var address: String!
    var ref: FIRDatabaseReference?
    var key: String!
    var postId: String!
    
    
    init(imageURL: String, title: String, address: String, description: String, occupancy: String, price: String,contact: String, location: String, key: String = "" , postId:String ){
        
        self.title = title
        self.description = description
        self.address = address
        self.contact = contact
        self.occupancy = occupancy
        self.imageURL = imageURL
        self.location = location
        self.price = price
        self.key = key
        self.postId = postId
        self.ref = FIRDatabase.database().reference()
        
        
    }
    
    init(snapshot: FIRDataSnapshot){
        
    
        self.imageURL = snapshot.value!["imageURL"] as! String
        self.title = snapshot.value!["title"] as! String
        self.description = snapshot.value!["description"] as! String
        self.contact = snapshot.value!["contact"] as! String
        self.occupancy = snapshot.value!["occupancy"] as! String
        self.location = snapshot.value!["Location"] as! String
        self.price = snapshot.value!["Price"] as! String
        self.address = snapshot.value!["address"] as! String
        self.key = snapshot.key
        self.ref = snapshot.ref
        self.postId = snapshot.value!["postId"] as! String
        
        
    }
    
    func toAnyObject() -> [String: AnyObject] {
        
        return ["imageURL": imageURL,"title":title,"description": description,"contact":contact,"occupancy":occupancy, "Location": location ,"Price": price, "address":address, "postId": postId]
    }
    
    
    
    
    
    
    
}
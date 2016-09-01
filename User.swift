//
//  User.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/23/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct User {
    
    var username: String!
    var email: String!
    var photoURL: String!
    var ref: FIRDatabaseReference?
    var key: String


    init(snapshot: FIRDataSnapshot){
        
        key = snapshot.key
        
        username = snapshot.value!["username"] as! String
    
        
        
        email  = snapshot.value!["email"] as! String
        
        photoURL = snapshot.value!["photoUrL"] as! String
        
        ref = snapshot.ref
        
        
        
    }
}
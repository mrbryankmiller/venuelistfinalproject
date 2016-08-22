//
//  NetworkingService.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/18/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct NetworkingService {
    
    var databaseRef: FIRDatabaseReference! {
    return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()

    }
    
    
    
    //3rd function
    //save info in database
    
    private func saveInfo (user: FIRUser!, username: String, password: String){
        //create our user dictionary info
        
        let userInfo = ["email": user.email!,"username":username,"uid":user.uid,"photoUrL":String(user.photoURL!)]
        
        //creat user Reference // will be saved on cloud
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        //save the user info in the Database
        
        userRef.setValue(userInfo)
        
        //Sign in User
        signIn(user.email!, password: password)
        
    }
    
    //4th function
    //Signing in the user 
    
        
    func signIn(email:String, password: String) {
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: {(user,error) in
            if error == nil {
                
                if let user = user {
                    print("\(user.displayName!) has signed in successfully!")
                }
                
            }else{
                print (error!.localizedDescription)
            }
        })
    }

    
    // 2nd Function
    // Set user Info
    
    private func setUserInfo(user: FIRUser!, username: String, password: String, data:NSData!){
        
        //create Path for the User Image
        let imagePath = "profileImage\(user.uid)/userpic.jpg"
        
        // Create Image Reference
        
        let imageRef = storageRef.child(imagePath)
        
        // Create Metadata for the image
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        //Save the user Image in the FireBase Storage File
        
        imageRef.putData(data, metadata: metaData) { (metaData, error) in
            if error == nil {
                
                let changeReuqest = user.profileChangeRequest()
                changeReuqest.displayName = username
                changeReuqest.photoURL = metaData!.downloadURL()
                changeReuqest.commitChangesWithCompletion({(error)in
                    
                    if error == nil {
                        self.saveInfo(user, username: username, password: password)
                        
                    }else{
                         print(error!.localizedDescription)
                    }
                })
                    
                
            } else {
                print(error!.localizedDescription)
            }
        
        }
    }
    
    //1st Function
    //we create the user 
    
    
    func signUp (email: String, username: String, password: String, data:NSData!){
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: {(user, error) in
            
            if error == nil {
                self.setUserInfo(user, username: username, password: password, data: data)
            }else {
                print (error!.localizedDescription)
            }
        
        })
        
    }
    
}



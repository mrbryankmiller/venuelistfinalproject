//
//  VenueListTableViewController.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/16/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class VenueListTableViewController: UITableViewController {

   var venuePostArray = [venuePost]()
    var databaseRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    let venueRef = databaseRef.child("posts")
    venueRef.observeEventType(.Value, withBlock: { (snapshot) in
        
        var newItems = [venuePost]()
        
        for item in snapshot.children {
            let newVenuePost = venuePost(snapshot: item as! FIRDataSnapshot)
            newItems.insert(newVenuePost, atIndex: 0)
            
        }
        self.venuePostArray = newItems
        self.tableView.reloadData()
        
        print(self.venuePostArray.count)
        
        
        }) { (error) in
            print (error.localizedDescription)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venuePostArray.count
    }
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return
//    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("passData", sender: self)
//    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell

        // Configure the cell...
        
        cell.titleLabel.text = venuePostArray[indexPath.row].title
        cell.locationLabel.text = venuePostArray[indexPath.row].location
        cell.priceLabel.text = venuePostArray[indexPath.row].price
        
        
        
        
        FIRStorage.storage().referenceForURL(venuePostArray[indexPath.row].imageURL).dataWithMaxSize(1 * 1024 * 1024) { (imagedata, error) in
            if error == nil {
                
                dispatch_async(dispatch_get_main_queue(), { 
                    if let data = imagedata {
                        
                        cell.postImageView.image = UIImage(data: data)
                        
                    }
                })
                
               
                
            }else {
                print(error?.localizedDescription)
            }
        }
        
        

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "passData"{
            let indexPath = tableView.indexPathForSelectedRow!
            let venueDetailVC = segue.destinationViewController as! VenueDetailTableViewController
            venueDetailVC.currentVenuePost = venuePostArray[indexPath.row]}
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

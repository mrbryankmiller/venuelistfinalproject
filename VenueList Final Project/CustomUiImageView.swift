//
//  CustomUiImageView.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/22/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit


// use this class to customize your own image view 


@IBDesignable class CustomUiImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderwidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderwidth
            
        }
        
    }
    
//    
//    @IBInspectable var borderColor: CGColor? = UIColor.blackColor().CGColor {
//        didSet{
//            layer.borderColor = borderColor
//            
//        }
//        
//    }
//    
    
    

}

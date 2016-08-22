//
//  CustomButton.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/22/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {

   
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }

}

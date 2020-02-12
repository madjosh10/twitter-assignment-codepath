//
//  RoundButton.swift
//  Twitter
//
//  Created by Joshua Madrigal on 2/12/20.
//  Copyright © 2020 Joshua Madrigal. All rights reserved.
//

import UIKit

/*
 Three separate initializer functions are called based on what context the RoundButton is created in:
 
 init(frame:) is for programmatically created buttons
 init?(coder:) is for Storyboard/.xib created buttons
 prepareForInterfaceBuilder() is called within the Storyboard editor itself for rendering @IBDesignable controls
 */



@IBDesignable class RoundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
        
    } // overriding the UIButton superclass
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }// end cornerRadius Func
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    } // end prepareForInterfaceBuilder Func
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
        
    }// end sharedInit Func
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
        
    }// end refreshCorners Func
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
        
    } // end cornerRadius Func
    
} // end RoundButton class

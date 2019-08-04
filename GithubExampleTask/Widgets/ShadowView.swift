//
//  ShadowView.swift
//  Carsoug
//
//  Created by Mena Gamal on 6/1/18.
//  Copyright © 2018 Mena Gamal. All rights reserved.
//


import UIKit

class ShadowView: UIView {
    
    override func didMoveToWindow() {
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
        // sets the path for the shadow to save ondraw time
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        // cache the shadow so it isn't redrawn
        //        self.layer.shouldRasterize = true
        
        super.didMoveToWindow()
    }
}



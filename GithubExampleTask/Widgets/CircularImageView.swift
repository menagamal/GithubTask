//
//  CircularImageView.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/21/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//


import UIKit

class CircularImageView: UIImageView {
    
    override func didMoveToWindow() {
        
        let size = frame.size.width
        self.layer.cornerRadius = size / 2
        clipsToBounds = true
        
        super.didMoveToWindow()
    }
}


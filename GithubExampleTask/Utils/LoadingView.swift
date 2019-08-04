//
//  LoadingView.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//


import UIKit

public class LoadingView: UIView {
    
    static var loadingSize: Int = 100
    
    var imageView: UIImageView!// = UIImageView(image: UIImage(named: "loading"))
    
    var viewFrame = UIScreen.main.bounds
    
    static var str:String!
    
    static let shared = LoadingView(name: str)
    
    private init(name:String) {
        super.init(frame:viewFrame)
        
        imageView = UIImageView(image: UIImage(named: name))
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        self.isHidden = true
        
        imageView.frame = CGRect(x: self.frame.width / 2 - CGFloat(LoadingView.loadingSize / 2), y: self.frame.height / 2 - CGFloat(LoadingView.loadingSize / 2), width: CGFloat(LoadingView.loadingSize), height: CGFloat(LoadingView.loadingSize))
        
        addSubview(imageView)
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        
    }
    
    private override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func startLoading() {
        isHidden = false
        superview?.bringSubviewToFront(self)
        imageView.startAnimating()
        
        if !imageView.isAnimating {
            
            let rotation = CABasicAnimation(keyPath: "transform.rotation")
            rotation.fromValue = 0
            rotation.toValue = (2 * Double.pi)
            rotation.duration = 1.5
            rotation.repeatCount = Float.greatestFiniteMagnitude
            
            imageView.layer.removeAllAnimations()
            imageView.layer.add(rotation, forKey: "rotation")
        }
    }
    
    public func stopLoading() {
        isHidden = true
        imageView.stopAnimating()
    }
    
}

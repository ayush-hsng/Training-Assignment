//
//  LoadingAnimationManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 05/09/23.
//

import Foundation
import UIKit

class Loader {
    var frozenBackgroundView: UIView
    var activityAnimation: UIActivityIndicatorView
    
    init(superview: UIView){
        frozenBackgroundView = UIView(frame: superview.frame)
        frozenBackgroundView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        let rectangularFrame = CGRect(
            x: CGFloat((superview.frame.width) / 2 ) - 50,
            y: CGFloat((superview.frame.height) / 2 ) - 50,
            width: 100,
            height: 100)
        activityAnimation = UIActivityIndicatorView(frame: rectangularFrame)
        activityAnimation.startAnimating()
    }
    
    func removeLoader() {
        self.activityAnimation.removeFromSuperview()
        self.frozenBackgroundView.removeFromSuperview()
    }
}

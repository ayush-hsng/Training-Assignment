//
//  LoadingAnimationManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 05/09/23.
//

import Foundation
import UIKit

class Loader {
    var loadingAlert: UIAlertController
    var spinner: UIActivityIndicatorView
    
    init(){
        loadingAlert = UIAlertController(title: nil, message: "Please Wait", preferredStyle: .alert)
        spinner = UIActivityIndicatorView(frame: CGRect(x: 48, y: 32, width: 0, height: 0))
        loadingAlert.view.addSubview(spinner)
        spinner.startAnimating()
    }

}

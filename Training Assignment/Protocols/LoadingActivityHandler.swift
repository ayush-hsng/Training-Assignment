//
//  LoaderProtocol.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 08/09/23.
//

import Foundation
import UIKit

protocol LoadingActivityHandler {
    func addLoader(onto superview: UIView)
    func removeLoader()
}

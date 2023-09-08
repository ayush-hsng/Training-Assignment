//
//  CacheHandler.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import Foundation
import UIKit

protocol CacheHandler {
    func invalidateCache()
}

protocol ImageCaheHandler: CacheHandler {
    var imageCache: [String: UIImage] { get set }
}

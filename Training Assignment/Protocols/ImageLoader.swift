//
//  ImageLoader.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import Foundation
import UIKit

protocol ImageLoader {
    func loadImage(from urlString:String,onCompletion: @escaping (UIImage) -> (Void))
    func getPlaceholderImage() -> UIImage
}

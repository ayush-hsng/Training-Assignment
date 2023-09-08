//
//  MVC Pattern.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import Foundation

protocol ViewControllerProtocol: Observer {
    var viewDataModel: ViewDataModelProtocol! { get set }
}

protocol ViewDataModelProtocol: Observable {
    
}

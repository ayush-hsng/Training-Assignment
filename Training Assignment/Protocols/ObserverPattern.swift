//
//  ObserverPattern.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 03/09/23.
//
// File Responsibility - Define protocols for implementing the Observer Pattern

import Foundation

protocol Observer {
    func notifyMeWhenDone()
}

protocol IndetifiableObserver: Observer {
    var observerID: UUID! { get set }
}

protocol Observable {
    var observers: [UUID: Observer] {get set}
    func subscribe(observer: Observer) -> UUID
    func unsubscribe(id: UUID)
    func notifyObservers()
}

//protocol DataModel {
//    func setData()
//    func processData()
//}
//
//protocol ViewDataModel: Observer,DataModel {
//    
//}

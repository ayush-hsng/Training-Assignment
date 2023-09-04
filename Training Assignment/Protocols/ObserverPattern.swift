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

protocol Observable {
    var observer: Observer? {get set}
    func subscribe(observer: Observer)
    func unsubscribe()
    func notifyObserver()
}

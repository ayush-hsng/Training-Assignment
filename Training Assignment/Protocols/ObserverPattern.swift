//
//  ObserverPattern.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 03/09/23.
//
// File Responsibility - Define protocols for implementing the Observer Pattern

import Foundation

protocol Observer {
    var observerID: UUID! { get set }
    func notifyMeWhenDone()
}

protocol Observable {
    var observers: [UUID: Observer] {get set}
    func subscribe(observer: Observer) -> UUID
    func unsubscribe(observer: Observer)
    func notifyAllObservers()
    func notifyObserver(with observerID: UUID)
}

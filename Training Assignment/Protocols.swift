//
//  Protocols.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 29/08/23.
//

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

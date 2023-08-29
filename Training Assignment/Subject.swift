//
//  Subject.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 29/08/23.
//

import Foundation

protocol Subject {
    func subscribe(observer: Observer)
    func unsubscribe()
    func notifyObserver()
}

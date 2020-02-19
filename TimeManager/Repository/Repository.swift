//
//  Repository.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 18/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype T
    
    func getAll() -> [T]
    func get( identifier:Int ) -> T?
    func create( a:T ) -> Bool
    func update( a:T ) -> Bool
    func delete( a:T ) -> Bool
}

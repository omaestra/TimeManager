//
//  CoreDataRepository.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 18/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataRepository: Repository {
    associatedtype T
    
    func create<T: NSManagedObject>() -> T
}

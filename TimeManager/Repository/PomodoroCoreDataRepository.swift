//
//  PomodoroCoreDataRepository.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 18/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation
import CoreData

class PomodoroCoreDataRepository: CoreDataRepository {
    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }
    
    func create<T>() -> T where T : NSManagedObject {
        return Pomodoro(entity: Pomodoro.entity(), insertInto: context) as! T
    }
    
    func getAll() -> [Pomodoro] {
        let fetchRequest: NSFetchRequest<Pomodoro> = Pomodoro.fetchRequest()
        do {
            let pomodoros = try context.fetch(fetchRequest)
            return pomodoros
        } catch {
            print("[ERROR]: Error fetching Pomodoros from CoreData")
            return []
        }
    }
    
    func get(identifier: Int) -> Pomodoro? {
        let fetchRequest: NSFetchRequest<Pomodoro> = Pomodoro.fetchRequest()
        
        do {
            let pomodoro = try fetchRequest.execute().first
            return pomodoro
        } catch {
            print("[ERROR]: Error fetching Pomodoro from CoreData")
            return nil
        }
    }
    
    func create(a: Pomodoro) -> Bool {
        do {
            context.insert(a)
            try context.save()
            return true
        } catch {
            debugPrint(error)
            return false
        }
    }
    
    func update(a: Pomodoro) -> Bool {
        return false
    }
    
    func delete(a: Pomodoro) -> Bool {
        return false
    }
    
    typealias T = Pomodoro
}

//
//  WorkSessionPresenter.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 03/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol WorkSessionViewDelegate: class {
    func updateUI()
}

class WorkSessionPresenter {
    var delegate: WorkSessionViewDelegate?
    
    var repository = PomodoroCoreDataRepository()
    
    var workSession: WorkSession?
    var task: Task?
    
//    init() {
//        session = Session(title: "New work", type: .focus, duration: 20)
//        workSession = WorkSession(session: session)
//    }
    
    init(task: Task? = nil) {
        if task == nil {
            self.task = Task(title: "newTask")
        } else {
            self.task = task
        }
        
//        guard let session = self.task?.sessions?.first else { return }
//        workSession = WorkSession(session: session)
        
        workSession = WorkSession()
    }
    
    func saveSession() {
        let pomodoro = Pomodoro(context: CoreDataManager.shared.viewContext)
        pomodoro.startDate = self.workSession?.startDate
        pomodoro.endDate = self.workSession?.endDate
        pomodoro.type = self.workSession?.session?.type.rawValue ?? ""
        pomodoro.duration = self.workSession?.duration ?? 0
        let _ = repository.create(a: pomodoro)
    }
    
    func loadNextSession() {
//        let nextSession = task?.sessions?.first(where: { (session) -> Bool in
//            !(workSession?.intervals.map({ $0 }).contains(where: { $0 == session }) ?? false)
//        })
        
        workSession?.session = workSession?.getNextSession()
        delegate?.updateUI()
    }
}

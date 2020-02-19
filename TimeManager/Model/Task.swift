//
//  Task.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 03/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class Task {
    var title: String
    var notes: String?
    var isCompleted: Bool = false
    var workingDuration: Int?
    var estimatedWorkTime: Int?
    var completedPercentage: Double?
    var dueDate: Date?
    
    var sessions: [Session]?
    
//    init(workSession: WorkSession) {
//        self.workSession = workSession
//    }
    
    private static var defaultSessions: [Session] {
        return [
//            Session(title: "Focus session 1", type: .focus, duration: 2),
//            Session(title: "Break session 1", type: .rest, duration: 1),
//            Session(title: "Focus session 2", type: .focus, duration: 2),
//            Session(title: "Break session 2", type: .rest, duration: 1),
        ]
    }
    
    
    init(title: String, notes: String? = nil, isCompleted: Bool = false, workingDuration: Int? = nil, estimatedWorkTime: Int? = nil, completedPercentage: Double? = nil, dueDate: Date? = nil, sessions: [Session]? = defaultSessions) {
        self.title = title
        self.notes = notes
        self.isCompleted = isCompleted
        self.workingDuration = workingDuration
        self.estimatedWorkTime = estimatedWorkTime
        self.completedPercentage = completedPercentage
        self.dueDate = dueDate
        self.sessions = sessions
    }
}

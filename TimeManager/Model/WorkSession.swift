//
//  WorkSession.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 03/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

enum FocusSessionState {
    case notStarted
    case active
    case completed
    case paused
}

class WorkSession {
    private (set) var startDate: Date!
    private (set) var endDate: Date!
    
    var session: Session?
//    var intervals: [Session] = []
    var intervals: [SessionInterval] = []
    
    var state: FocusSessionState = .notStarted
    
    var duration: TimeInterval {
        return Double(intervals.map({ $0.duration }).reduce(0, +))
    }
    
    // MARK: - Initializers
    
    init() {
        self.session = getNextSession()
        self.intervals = []
    }
    
    init(session: Session) {
        self.session = session
        self.intervals = []
    }
    
    // MARK: - Instance methods
    
    func start() {
        startDate = Date()
        state = .active
    }
    
    func end() {
        endDate = Date()
        if startDate == nil {
            self.startDate = endDate
        }
        addNewInterval()
        state = .completed
    }
    
    func clear() {
        startDate = nil
        endDate = nil
        state = .notStarted
    }
    
    func pause() {
        state = .paused
    }
    
    func resume() {
        // TODO: Implement resume
        state = .active
    }
    
    func getNextSession() -> Session {
        guard let lastSession = intervals.compactMap({ $0.session }).last else {
            return SessionFactory.shared.createSession(sessionType: .focus, sessionTitle: "")
        }
        
        switch lastSession.type {
        case .focus:
            if ((intervals.compactMap({ $0.session }).filter({ $0.type == .focus }).count) % 4) == 0 {
                return SessionFactory.shared.createSession(sessionType: .longBreak, sessionTitle: "")
            } else {
                return SessionFactory.shared.createSession(sessionType: .shortBreak, sessionTitle: "")
            }
        case .shortBreak, .longBreak:
            return SessionFactory.shared.createSession(sessionType: .focus, sessionTitle: "")
        }
    }
    
    private func addNewInterval() {
        guard let session = session else {
            print("[WARNING]: Could not addNewInterval to WorkSession")
            return
        }
//        intervals.append(session)
        let interval = SessionInterval(session: session, start: startDate, end: endDate)
        intervals.append(interval)
    }
}

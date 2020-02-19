//
//  SessionFactory.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 18/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class SessionFactory {
    static let shared = SessionFactory()
    
    private init() {}
    
    func createSession(sessionType: SessionType, sessionTitle: String) -> Session {
        switch sessionType {
        case .focus:
            let duration = Int(UserDefaults.standard.focusDuration)
            return Session(title: sessionTitle, type: .focus, duration: duration)
        case .shortBreak:
            let duration = Int(UserDefaults.standard.shortBreakDuration)
            return Session(title: sessionTitle, type: .shortBreak, duration: duration)
        case .longBreak:
            let duration = Int(UserDefaults.standard.longBreakDuration)
            return Session(title: sessionTitle, type: .longBreak, duration: duration)
        }
    }
}

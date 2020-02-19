//
//  Session.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 03/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

enum SessionType: String, Codable {
    case focus
    case shortBreak
    case longBreak
}


/// Session object
class Session: Codable {
    var title: String
    var type: SessionType
    // Session duration is measured in seconds
    var duration: Int
    
    init(title: String, type: SessionType, duration: Int) {
        self.title = title
        self.type = type
        self.duration = duration
    }
}

extension Session: Equatable {
    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.title == rhs.title &&
        lhs.type == rhs.type &&
        lhs.duration == rhs.duration
    }
}

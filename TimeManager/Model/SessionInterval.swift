//
//  SessionInterval.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 03/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

struct SessionInterval {
    var start: Date
    var end: Date
    var session: Session?
    
    init(session: Session? = nil, start: Date, end: Date) {
        self.session = session
        self.start = start
        self.end = end
    }
    
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
}

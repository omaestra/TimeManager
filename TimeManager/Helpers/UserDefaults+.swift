//
//  UserDefaults+.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 10/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

extension UserDefaults {
    struct Keys {
        private init() {}
        
        static let focusDuration = "focusDuration"
        static let shortBreakDuration = "shortBreakDuration"
        static let longBreakDuration = "longBreakDuration"
        static let rounds = "rounds"
    }
    
    var focusDuration: Double {
        get {
            return UserDefaults.standard.double(forKey: Keys.focusDuration)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.focusDuration)
            UserDefaults.standard.synchronize()
        }
    }
    
    var shortBreakDuration: Double {
        get {
            return UserDefaults.standard.double(forKey: Keys.shortBreakDuration)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.shortBreakDuration)
            UserDefaults.standard.synchronize()
        }
    }
    
    var longBreakDuration: Double {
        get {
            return UserDefaults.standard.double(forKey: Keys.longBreakDuration)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.longBreakDuration)
            UserDefaults.standard.synchronize()
        }
    }
    
    var rounds: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.rounds)
        }
        set {
            UserDefaults.standard.set(rounds, forKey: Keys.rounds)
            UserDefaults.standard.synchronize()
        }
    }
}

//
//  SettingsPresenter.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 10/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol SettingsViewDelegate: class {
    func updateUI()
}

class SettingsPresenter {
    var delegate: SettingsViewDelegate?
    
    // Constants
    let minFocusTime: Float = 1
    let maxFocusTime: Float = 60*60
    
    let minShortBreakTime: Float = 1
    let maxShortBreakTime: Float = 5*60
    
    let minLongBreakTime: Float = 1
    let maxLongBreakTime: Float = 15*60
    
    let minRoundsValue: Int = 1
    let maxRoundsValue: Int = 8
    
    // Instance Properties
    var focusTime: Float
    var shortBreakTime: Float
    var longBreakTime: Float
    var rounds: Int
    
    // MARK: - Initializers
    
    init(focusTime: Float = 25*60, shortBreakTime: Float = 5*60, longBreakTime: Float = 15*60, rounds: Int = 4) {
        self.focusTime = focusTime
        self.shortBreakTime = shortBreakTime
        self.longBreakTime = longBreakTime
        self.rounds = rounds
    }
    
    // MARK: - Instance methods
    
    func formatAsMinutes(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        
        let formattedDuration = formatter.string(from: duration)
        return formattedDuration ?? ""
    }
    
    func updateValues(focusTime: Float, shortBreakTime: Float, longBreakTime: Float, rounds: Float) {
        self.focusTime = round(focusTime / 30) * 30
        self.shortBreakTime = round(shortBreakTime / 30) * 30
        self.longBreakTime = round(longBreakTime / 30) * 30
        self.rounds = Int(rounds)
        
        UserDefaults.standard.focusDuration = Double(self.focusTime)
        UserDefaults.standard.shortBreakDuration = Double(self.shortBreakTime)
        UserDefaults.standard.longBreakDuration = Double(self.longBreakTime)
        UserDefaults.standard.rounds = Int(self.rounds)
        UserDefaults.standard.synchronize()
        
        delegate?.updateUI()
    }
}

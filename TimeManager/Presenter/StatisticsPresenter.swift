//
//  StatisticsPresenter.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 18/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol StatisticsViewDelegate: class {
    func updateUI()
}

class StatisticsPresenter {
    var repository = PomodoroCoreDataRepository()
    
    var delegate: StatisticsViewDelegate?
    
    var pomodoros: [Pomodoro]?
    
    init() {
        
    }
    
    func loadPomodoros() {
        pomodoros = repository.getAll()
    }
}

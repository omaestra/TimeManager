//
//  SettingsTableViewController.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 10/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var focusTitleLabel: UILabel!
    @IBOutlet weak var focusValueLabel: UILabel!
    @IBOutlet weak var focusSlider: UISlider!
    @IBOutlet weak var shortBreakTitleLabel: UILabel!
    @IBOutlet weak var shortBreakValueLabel: UILabel!
    @IBOutlet weak var shortBreakSlider: UISlider!
    @IBOutlet weak var longBreakTitleLabel: UILabel!
    @IBOutlet weak var longBreakValueLabel: UILabel!
    @IBOutlet weak var longBreakSlider: UISlider!
    @IBOutlet weak var roundsTitleLabel: UILabel!
    @IBOutlet weak var roundsValueLabel: UILabel!
    @IBOutlet weak var roundsSlider: UISlider!
    
    var presenter: SettingsPresenter = SettingsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        focusSlider.minimumValue = presenter.minFocusTime
        focusSlider.maximumValue = presenter.maxFocusTime
        focusSlider.value = presenter.focusTime
        
        shortBreakSlider.minimumValue = presenter.minShortBreakTime
        shortBreakSlider.maximumValue = presenter.maxShortBreakTime
        shortBreakSlider.value = presenter.shortBreakTime
        
        longBreakSlider.minimumValue = presenter.minLongBreakTime
        longBreakSlider.maximumValue = presenter.maxLongBreakTime
        longBreakSlider.value = presenter.longBreakTime
        
        roundsSlider.minimumValue = Float(presenter.minRoundsValue)
        roundsSlider.maximumValue = Float(presenter.maxRoundsValue)
        roundsSlider.value = Float(presenter.rounds)
        
        updateUI()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        presenter.updateValues(focusTime: focusSlider.value,
                               shortBreakTime: shortBreakSlider.value,
                               longBreakTime: longBreakSlider.value,
                               rounds: roundsSlider.value)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsTableViewController: SettingsViewDelegate {
    func updateUI() {
        focusValueLabel.text = "\(presenter.formatAsMinutes(duration: TimeInterval(presenter.focusTime)))"
        shortBreakValueLabel.text = "\(presenter.formatAsMinutes(duration: TimeInterval(round(shortBreakSlider.value / 30) * 30)))"
        longBreakValueLabel.text = "\(presenter.formatAsMinutes(duration: TimeInterval(round(longBreakSlider.value / 30) * 30)))"
        roundsValueLabel.text = "\(Int(roundsSlider.value))"
    }
}

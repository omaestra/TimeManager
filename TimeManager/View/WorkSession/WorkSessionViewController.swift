
//
//  WorkSessionViewController.swift
//  TimeManager
//
//  Created by Oswaldo Maestra on 03/10/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

protocol WorkSessionDelegate: class {
    func sessionDidEnd()
    func sessionCancelled()
}

class WorkSessionViewController: UIViewController {
    
    @IBOutlet weak var sessionStatusLabel: UILabel!
    @IBOutlet weak var circularTimerView: CircularTimerView! {
        didSet {
            circularTimerView.delegate = self
        }
    }
    @IBOutlet weak var sessionIntervalLabel: UILabel!
    @IBOutlet weak var pomodorosStackView: UIStackView!
    
    @IBOutlet weak var currentTaskContainerView: UIView!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskValueLabel: UILabel!
    
    var presenter: WorkSessionPresenter? {
        didSet {
            presenter?.delegate = self
        }
    }
    var delegate: WorkSessionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        currentTaskContainerView.layer.cornerRadius = 8.0
        if let task = presenter?.task {
            taskValueLabel.text = task.title
            
            currentTaskContainerView.isHidden = false
        } else {
            currentTaskContainerView.isHidden = true
        }
        
        pomodorosStackView.subviews.forEach { (view) in
            view.alpha = 0.3
        }
//        for index in presenter?.workSession?.intervals.indices ?? [].indices {
//            DispatchQueue.main.async {
//                UIView.animate(withDuration: 0.3) {
//                    self.pomodorosStackView.arrangedSubviews[index].alpha = 1.0
//                }
//            }
//        }
        
        sessionStatusLabel.text = presenter?.workSession?.session?.type.rawValue.capitalized
        
        circularTimerView.useMinutesAndSecondsRepresentation = true
        circularTimerView.labelFont = UIFont.boldSystemFont(ofSize: 32)
        circularTimerView.timerFinishingText = "FINISHED"
        circularTimerView.configure(beginingValue: presenter?.workSession?.session?.duration ?? 0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func playButtonPressed(_ sender: UIButton) {
        guard let session = presenter?.workSession?.session else { return }
        switch presenter?.workSession?.state {
        case .active?:
            circularTimerView.pause()
        case .notStarted?:
            circularTimerView.start(beginingValue: session.duration)
        case .paused?:
            circularTimerView.resume()
        case .completed?:
            circularTimerView.end()
        default:
            break
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.sessionCancelled()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension WorkSessionViewController: CircularTimerViewDelegate {
    func timerDidStart() {
        presenter?.workSession?.start()
    }
    
    func timerDidPause() {
        presenter?.workSession?.pause()
    }
    
    func timerDidResume() {
        presenter?.workSession?.resume()
    }
    
    func timerDidEnd() {
        presenter?.workSession?.end()
        presenter?.saveSession()
        presenter?.workSession?.clear()
        presenter?.loadNextSession()
    }
}

extension WorkSessionViewController: WorkSessionViewDelegate {
    func updateUI() {
        setupUI()
    }
}

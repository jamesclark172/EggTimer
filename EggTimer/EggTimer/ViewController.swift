//
//  ViewController.swift
//  EggTimer
//
//  Created by dealermade on 7/24/17.
//  Copyright © 2017 dealermade. All rights reserved.
//

import Cocoa

extension ViewController {
    func setupPrefs() {
        updateDisplay(for: prefs.selectedTime)

        let notificationName = Notification.Name(rawValue: "PrefsChanged")
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: nil) {

            (notification) in
            self.updateFromPrefs()
        }
    }
    func updateFromPrefs() {
        self.eggTimer.duration = self.prefs.selectedTime
        self.resetButtonClicked(self)
    }
}


extension ViewController {
    func updateDisplay(for timeRemaining: TimeInterval) {
        timeLeftField.stringValue = textToDisplay(for: timeRemaining)
        eggImageView.image = imageToDisplay(for: timeRemaining)
    }

    private func textToDisplay(for timeRemaining: TimeInterval) -> String {
        if timeRemaining == 0 {
            return "Done!"
        }

        let minutesRemaining = floor(timeRemaining / 60)
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)

        let secondsDisplay = String(format: "%02d", Int(secondsRemaining))
        let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"

        return timeRemainingDisplay
    }

    private func imageToDisplay(for timeRemaining: TimeInterval) -> NSImage? {
        let percentageComplete = 100 - (timeRemaining / 360 * 100)

        if eggTimer.isStopped {
            let stoppedImageName = (timeRemaining == 0) ? "100" : "stopped"
            return NSImage(named: stoppedImageName)
        }

        let imageName: String
        switch percentageComplete {
        case 0 ..< 25:
            imageName = "0"
        case 25 ..< 50:
            imageName = "25"
        case 50 ..< 75:
            imageName = "50"
        case 75 ..< 100:
            imageName = "75"
        default:
            imageName = "100"
        }

        return NSImage(named: imageName)
    }

    func configureButtonAndMenus() {
        let enableStart: Bool
        let enableStop: Bool
        let enableReset: Bool

        if eggTimer.isStopped {
            enableStart = true
            enableStop = false
            enableReset = false
        }
            else if eggTimer.isPaused {
                enableStart = true
                enableStop = false
                enableReset = true
        }
            else {
                enableStart = false
                enableStop = true
                enableReset = false
        }

        startButton.isEnabled = enableStart
        stopButton.isEnabled = enableStop
        resetButton.isEnabled = enableReset

        if let appDel = NSApplication.shared().delegate as? AppDelegate {
            appDel.enableMenus(start: enableStart, stop: enableStop, reset: enableReset)

        }
    }
}

extension ViewController: EggTimerProtocol {

    func timeRemainingOnTimer(_ timer: EggTimer, timeRemaining: TimeInterval) {
        updateDisplay(for: timeRemaining)
    }

    func timerHasFinished(_ timer: EggTimer) {
        updateDisplay(for: 0)
    }
}

class ViewController: NSViewController {


    @IBOutlet weak var timeLeftField: NSTextField!
    @IBOutlet weak var eggImageView: NSImageCell!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var resetButton: NSButton!

    var eggTimer = EggTimer()
    var prefs = Prefrences()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPrefs()

        eggTimer.delegate = self
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }


    @IBAction func startButtonClicked(_ sender: Any) {
        if eggTimer.isPaused {
            eggTimer.resumeTimer()
        }
            else {
                eggTimer.duration = 360
                eggTimer.startTimer()
        }
        configureButtonAndMenus()
    }



    @IBAction func stopButtonClicked(_ sender: Any) {
        eggTimer.stopTimer()
        configureButtonAndMenus()
    }

    @IBAction func resetButtonClicked(_ sender: Any) {
        eggTimer.resetTimer()
        updateDisplay(for: 360)
        configureButtonAndMenus()
    }
}



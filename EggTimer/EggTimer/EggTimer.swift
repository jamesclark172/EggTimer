//
//  EggTimer.swift
//  EggTimer
//
//  Created by dealermade on 7/25/17.
//  Copyright © 2017 dealermade. All rights reserved.
//

import Foundation

protocol EggTimerProtocol {
    func timeRemainingOnTimer(_ timer: EggTimer, timeRemaining: TimeInterval)
    func timerHasFinished(_ timer: EggTimer)
}

class EggTimer {
    var timer: Timer? = nil
    var startTime: Date?
    var duration: TimeInterval = 360   // default = 6 minutes
    var elapsedTime: TimeInterval = 0
    
    var isStopped: Bool {
        return timer == nil && elapsedTime == 0
    }
    var isPaused: Bool {
        return timer == nil && elapsedTime > 0
    }
    
    var delegate: EggTimerProtocol?
    
    dynamic func timerAction() {
        // 1 
        guard let startTime = startTime else {
            return
        }
        
        // 2
        elapsedTime = -startTime.timeIntervalSinceNow
        
        // 3
        let secondsRemaining = (duration - elapsedTime).rounded()
        
        // 4 
        if secondsRemaining <= 0 {
            resetTimer()
            delegate?.timerHasFinished(self)
            
        }
        else {
            delegate?.timeRemainingOnTimer(self, timeRemaining: secondsRemaining)
        }
    }
    // 1
    func startTimer()
    {
        startTime = Date()
        elapsedTime = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                    target: self,
                                    selector: #selector(timerAction),
                                    userInfo: nil,
                                    repeats: true)
        timerAction()
    }
    // 2 
    func resumeTimer() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        timerAction()
    }
    // 3 
    func stopTimer() {
        // just pauses the timer
        timer?.invalidate()
        timer = nil
        
        timerAction()
    }
    // 4 
    func resetTimer() {
        // stops timer and resets back to start
        timer?.invalidate()
        timer = nil
        
        startTime = nil
        duration = 360
        elapsedTime = 0
        
        timerAction()
    }
}





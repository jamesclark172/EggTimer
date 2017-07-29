//
//  Prefrences.swift
//  EggTimer
//
//  Created by dealermade on 7/26/17.
//  Copyright © 2017 dealermade. All rights reserved.
//

import Foundation

struct Prefrences {
    
    // 1 
    var selectedTime: TimeInterval {
        get {
            // 2 
            let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
            if savedTime > 0 {
                return savedTime
            }
            // 3 
            return 360
        }
        set {
            // 4
            UserDefaults.standard.set(newValue, forKey: "selectedTime")
        }
    }
}

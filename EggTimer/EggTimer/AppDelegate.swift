//
//  AppDelegate.swift
//  EggTimer
//
//  Created by dealermade on 7/24/17.
//  Copyright © 2017 dealermade. All rights reserved.
//

import Cocoa




@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var startTimerMenuItem: NSMenuItem!

    @IBOutlet weak var stopTimerMenuItem: NSMenuItem!

    @IBOutlet weak var resetTimerMenu: NSMenuItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        enableMenus(start: true, stop: false, reset: false)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        // Finished sucking eggs
    }
    
    func enableMenus(start: Bool, stop: Bool, reset: Bool) {
        startTimerMenuItem.isEnabled = start
        stopTimerMenuItem.isEnabled = stop
        resetTimerMenu.isEnabled = reset
    }


}


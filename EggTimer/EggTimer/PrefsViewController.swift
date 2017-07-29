//
//  PrefsViewController.swift
//  EggTimer
//
//  Created by dealermade on 7/25/17.
//  Copyright © 2017 dealermade. All rights reserved.
//

import Cocoa
import Foundation

class PrefsViewController: NSViewController {

    @IBOutlet weak var presetsPopup: NSPopUpButton!
    @IBOutlet weak var customSlider: NSSlider!
    @IBOutlet weak var customTextField: NSButton!
    
    var prefs = Prefrences()
    
    func showexistingPrefs() {
        let selectedTimeInMinutes = Int(prefs.selectedTime) / 60
        
        presetsPopup.selectItem(withTitle: "Custom")
        customSlider.isEnabled = true
        for item in presetsPopup.itemArray {
            if item.tag == selectedTimeInMinutes {
                presetsPopup.select(item)
                customSlider.isEnabled = false
                break
            }
        }
        
        customSlider.integerValue = selectedTimeInMinutes
        showSliderValueAsText()
    }
    
    func showSliderValueAsText() {
        let newTimerDuration = customSlider.integerValue
        let minutesDescription = (newTimerDuration == 1) ? "minute" : "minutes"
        customTextField.stringValue = "\(newTimerDuration) \(minutesDescription)"
    }
    
    func saveNewPrefs() {
        prefs.selectedTime = customSlider.doubleValue * 60
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Prefschanged"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showexistingPrefs()
    }
 
    @IBAction func popupButtonClicked(_ sender: NSPopUpButton) {
        if sender.selectedItem?.title == "Custom" {
            customSlider.isEnabled = true
            return
        }
        
        let newTimerDuration = sender.selectedTag()
        customSlider.integerValue = newTimerDuration
        showSliderValueAsText()
        customSlider.isEnabled = false
    }
    @IBAction func sliderValueChanged(_ sender: NSSlider) {
        showSliderValueAsText()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        view.window?.close()
    }
   
    @IBAction func okButtonClicked(_ sender: Any) {
        saveNewPrefs()
        view.window?.close()
    }
    
    
}

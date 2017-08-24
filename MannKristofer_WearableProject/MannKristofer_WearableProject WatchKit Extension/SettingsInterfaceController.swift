//
//  SettingsInterfaceController.swift
//  MannKristofer_WearableProject
//
//  Created by Kristofer Klae Mann on 8/13/17.
//  Copyright © 2017 Kristofer Klae Mann. All rights reserved.
//

import WatchKit
import Foundation

// This is the protocol for the SettingsDelegate
// It receives an array of boolean values
protocol SettingsDelegate {
    func changedSettings(valueArray:[Bool])
}

class SettingsInterfaceController: WKInterfaceController {
    
    // MARK - Outlet properties
    @IBOutlet var lowerSwitch: WKInterfaceSwitch!
    @IBOutlet var upperSwitch: WKInterfaceSwitch!
    @IBOutlet var numbersSwitch: WKInterfaceSwitch!
    @IBOutlet var symbolsSwitch: WKInterfaceSwitch!
    
    var delegate: InterfaceController?
    var switchValueArray = [Bool]()
    var swtichArray = [WKInterfaceSwitch]()
    
    // MARK - Actions
    // This calls the updateDelegateArrayValues method and provides the correct index and value of the switch
    @IBAction func lowerSwitchChangedValue(_ value: Bool) {
       updateDelegateArrayValues(index: 0, value: value)
    }
    
    // This performs the same as above for the upper switch
    @IBAction func upperSwitchChangedValue(_ value: Bool) {
        updateDelegateArrayValues(index: 1, value: value)
    }
    
    // This performs the same as above for the numbers switch
    @IBAction func numbersSwitchChangedValue(_ value: Bool) {
        updateDelegateArrayValues(index: 2, value: value)
    }
    
    // This performs the same as above for the symbols switch
    @IBAction func symbolsSwitchChangedValue(_ value: Bool) {
        updateDelegateArrayValues(index: 3, value: value)
    }
    
    // MARK - Functions
    // This takes in an integer and a boolean to determine which value is changed in the switchValueArray
    // It then calls the changedSettings method for the delegate to provide an updated array
    func updateDelegateArrayValues(index: Int,value: Bool){
        switchValueArray[index] = value
        self.delegate?.changedSettings(valueArray: switchValueArray)
    }

    // This adds all of the switches to an array so that a loop can turn them on/off based upon the context
    // The delgate is set to the context and the switchValueArray is set delgate's switchValueArray
    // This is for the user to see what changes they made to settings if they went back to its screen
    // Then is loops 4 times to turn on/off each switch based upon the switchValueArray index
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        swtichArray = [lowerSwitch,upperSwitch,numbersSwitch,symbolsSwitch]
        self.delegate = context as? InterfaceController
        switchValueArray = (self.delegate?.switchValueArray)!
        
        for index in 0...3{
            swtichArray[index].setOn(switchValueArray[index])
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }

    override func didDeactivate() {
        super.didDeactivate()
        
    }

}

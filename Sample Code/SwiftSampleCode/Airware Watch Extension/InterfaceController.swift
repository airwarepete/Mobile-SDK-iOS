//
//  InterfaceController.swift
//  Airware Watch Extension
//
//  Created by Eric Engstrom on 5/4/17.
//  Copyright © 2017 Airware. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, WatchSessionMessagesDelegate {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        WatchSessionManager.instance.setUp()
        WatchSessionManager.instance.register(self)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // WatchSessionMessagesDelegate implementation //////////////////////////////////////
    func messageReceived(data: [String : Any]) {
        
    }

    // button handlers /////////////////////////////////////////////////////////////////
    
    @IBAction func launchTouched() {
        // reset UI
        take360Button.setHidden(false)
        landingLabel.setHidden(true)
        activityRing.setHidden(true)
        landButton.setEnabled(true)
        
        WatchSessionManager.instance.send(["launch": true])
    }
    
    @IBAction func take360Touched() {
        take360Button.setHidden(true)
        landingLabel.setHidden(true)
        activityRing.setHidden(false)
        
        WatchSessionManager.instance.send(["take360": true])
    }
    
    @IBAction func landTouched() {
        take360Button.setHidden(true)
        landingLabel.setHidden(false)
        activityRing.setHidden(true)
        landButton.setEnabled(false)
        
        WatchSessionManager.instance.send(["land": true])
    }
    
    @IBAction func holdTouched() {
    }
    
    // ui element references //////////////////////////////////////////////////////////////
    
    @IBOutlet var landButton: WKInterfaceButton!
    @IBOutlet var take360Button: WKInterfaceButton!
    
    @IBOutlet var landingLabel: WKInterfaceLabel!
    
    @IBOutlet var activityRing: WKInterfaceActivityRing!
}

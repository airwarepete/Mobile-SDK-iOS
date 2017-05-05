//
//  WatchSessionManager.swift
//  DJISDKSwiftDemo
//
//  Created by Eric Engstrom on 5/4/17.
//  Copyright © 2017 Airware. All rights reserved.
//

import Foundation
import WatchConnectivity

// A class that wishes to receive messages from WatchSessionManager should implement this protocol, and register itself with WatchSessionManager.
protocol WatchSessionMessagesDelegate {
    // called when a message is received. data is a dictionary that contains the message's contents.
    func messageReceived(data: [String : Any])
}

class WatchSessionManager: NSObject, WCSessionDelegate {
    var watchActive: Bool = false
    private let wcSession = WCSession.isSupported() ? WCSession.default() : nil
    var delegate: WatchSessionMessagesDelegate?
    
    // singleton
    static let instance = WatchSessionManager()
    private override init() {
        super.init()
    }
    
    // Call to set up the communication channel
    func setUp() {
       wcSession?.delegate = self
       wcSession?.activate()
    }
    
    // register to receive messages
    func register(_ del: WatchSessionMessagesDelegate) {
        delegate = del
    }
    
    // send a message
    func send(data: [String : Any]) {
        if (watchActive) {
            wcSession?.sendMessage(data, replyHandler: nil)
        }
    }

    // WCSessionDelegate implementation //////////////////////////////////////
    
    // called on activation
    @available(iOS 9.3, *)
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?){
        watchActive = activationState == WCSessionActivationState.activated
    }
    
    // Needed to support multiple watches. Out of scope.
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    // Needed to support multiple watches. Out of scope.
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    // receive immediate messages from the watch (no response expected)
    func session(_ session: WCSession,
                 didReceiveMessage message: [String : Any]) {
        delegate?.messageReceived(data: message)
    }
}

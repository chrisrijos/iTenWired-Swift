//    Copyright (c) 2016, UWF
//    All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    * Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//    * Neither the name of UWF nor the names of its contributors may be used to
//    endorse or promote products derived from this software without specific
//    prior written permission.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//    POSSIBILITY OF SUCH DAMAGE.
//
//  NearMeController.swift
//  Conference App
//
//  Created by Felipe on 7/8/16.
//
//

import Foundation
import JMCiBeaconManager
import CoreLocation



enum NearMeControllerEnum : String {
    case NewBeaconRanged
}

class NearMeController {
    
    /// iBeacon data from JSON
    private let beaconData = IBeaconData()
    
    /// iBeaconManager - Awsome Lib :)
    private let beaconManager = JMCBeaconManager()
    
    
    /// Active Beacons Near Me
    private var activeBeacons = [String : ItenWiredBeacon]()
    
    
    /// Active Near Me Objects
    private var activeNearMe = [iBeaconNearMeProtocol]()
    
    /// Attendee Data from JSON
    private var attendeeData = AttendeeData()
    
    /// Locations Data from JSON
    private var locationsData = LocationData()
    
    
    init(){
        
        // iBeaconManager Setup
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconsRanged(_:)), name: iBeaconNotifications.BeaconProximity.rawValue, object: nil)
        
        // Get conference beacons from JSON
        let registeredBeacons = beaconData.getBeacons()
        
        /// Register beacons on JMCiBeaconManager
        beaconManager.registerBeacons(registeredBeacons)
        
        /// Start monitoring for the beacons
        beaconManager.startMonitoring({
            
        }) { (messages) in
            print("Error Messages \(messages)")
        }
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(NearMeController.removeOldBeacons), userInfo: nil, repeats: true)
    }
    
    @objc func removeOldBeacons() {
        
        var flag = false
        
        for beacon in activeBeacons.values {
        
            let now = NSDate()
            
            if beacon.lastRanged.addSeconds(1).isLessThanDate(now) {
            
                
                
                var index = 0
                
                for object in activeNearMe {
                    
                    if let otherBeacon = beaconData.getBeaconById(object.getBeaconId()) {
                    
                        
                        
                        if otherBeacon.UUID.equalsIgnoreCase(beacon.UUID) &&
                            otherBeacon.major == beacon.major &&
                            otherBeacon.minor == beacon.minor {
                        
                            flag = true
                            
                            activeBeacons[beacon.id] = nil
                            activeNearMe.removeAtIndex(index)
                        }
                    
                    }
                    
                    index = index + 1
                }
            }
        
        }
        
        if flag {
        
            NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.NewBeaconRanged.rawValue, object: nil)
        }
    }
    
    /**Called when the beacons are ranged*/
    @objc func beaconsRanged(notification:NSNotification){
        if let visibleIbeacons = notification.object as? [iBeacon]{
            for beacon in visibleIbeacons{
                
                
                print(beacon.UUID)
                
                let iTenWiredBeacon = ItenWiredBeacon(with: beacon)
                iTenWiredBeacon.lastRanged = NSDate()
                
                if(activeBeacons[iTenWiredBeacon.id] == nil){
                    newBeaconRanged(iTenWiredBeacon)
                }
                
                activeBeacons[iTenWiredBeacon.id] = iTenWiredBeacon
            }
        }
    }
    
    internal func getAllNearMe() -> [iBeaconNearMeProtocol] {
        return self.activeNearMe
    }
    
    private func newBeaconRanged(beacon: ItenWiredBeacon){
        
        for sponsor in attendeeData.getSponsers() {
            
            if let object = beaconData.getBeaconById(sponsor.iBeaconId) {
                
                if object.UUID.equalsIgnoreCase(beacon.UUID){
                
                    if object.major == beacon.major && object.minor == beacon.minor {
                        
                        if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: sponsor.getBeaconProximity()){
                            activeNearMe.append(sponsor)
                            break
                        }
                        
                    }
                }
            }
        }
        
        for exhibitor in attendeeData.getExibitors() {
            
            if let object = beaconData.getBeaconById(exhibitor.iBeaconId) {
                
                if object.UUID.equalsIgnoreCase(beacon.UUID){
                    
                    if object.major == beacon.major && object.minor == beacon.minor {
                        
                        if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: exhibitor.getBeaconProximity()){
                            activeNearMe.append(exhibitor)
                            break
                        }
                    }
                }
            }
        }
        
        for location in locationsData.getLocations() {
            
            if let object = beaconData.getBeaconById(location.iBeaconId) {
                
                if object.UUID.equalsIgnoreCase(beacon.UUID){
                    
                    if object.major == beacon.major && object.minor == beacon.minor {
                        
                        if  JMCBeaconManager.isInRange(beacon.proximity, requiredProximity: location.beaconProximity){
                            activeNearMe.append(location)
                            break
                        }
                        
    
                    }
                }
            }
        }
        
        // Notify that a new beacon was ranged
        NSNotificationCenter.defaultCenter().postNotificationName(NearMeControllerEnum.NewBeaconRanged.rawValue, object: nil)
    }
    
}

extension JMCBeaconManager {

    static func isInRange( objectProximity : CLProximity, requiredProximity: CLProximity) -> Bool {
    
        if requiredProximity == CLProximity.Immediate {
            
            if objectProximity == requiredProximity {
                return true
            }
        
            return false
        }
        
        if requiredProximity == CLProximity.Near {
        
            if objectProximity == requiredProximity ||
                objectProximity == CLProximity.Immediate {
                return true
            }
            
            return false
        }
        
        if requiredProximity == CLProximity.Far {
            
            if objectProximity == requiredProximity ||
                objectProximity == CLProximity.Immediate ||
                objectProximity == CLProximity.Near {
                return true
            }
        }
        
        return false
    }

}
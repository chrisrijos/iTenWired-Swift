//    Copyright (c) 2016, Izotx
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
//    * Neither the name of Izotx nor the names of its contributors may be used to
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
//
//  ItenWiredBeacon.swift
//  Conference App
//
//  Created by Felipe on 7/7/16.
//
//

import Foundation
import JMCiBeaconManager


enum ItenWiredBeaconEnum : String {
    case id
    case udid
    case minor
    case major
    case name
}

class ItenWiredBeacon : iBeacon {
    
    
    /// Date the beacon was last ranged
    internal var lastRanged : NSDate!
    
    /**
     Initializes the Beacon with the data provided in the dictionary
     */
    init(dictionary: NSDictionary) {
        
        
        var minor = 0
        var major = 0
        var id:String = ""
        var uuid = ""
        
        if let unwrapedMinor = dictionary.objectForKey(ItenWiredBeaconEnum.minor.rawValue) as? Int {
            minor = unwrapedMinor
        }
        
        if let unwrapedMajor = dictionary.objectForKey(ItenWiredBeaconEnum.major.rawValue) as? Int {
            major = unwrapedMajor
        }
      
        
        if let unwrapedID = dictionary.objectForKey(ItenWiredBeaconEnum.id.rawValue) as? String {
            id = unwrapedID
        }
        
        if let unwrapedUdid = dictionary.objectForKey(ItenWiredBeaconEnum.udid.rawValue) as?  String {
            uuid = unwrapedUdid
        }

        super.init(minor: UInt16(minor), major: UInt16(major), proximityId:uuid, id:id)
    }
    
    init(with beacon: iBeacon){
        super.init(minor: beacon.minor, major: beacon.major, proximityId: beacon.UUID, id: beacon.id)
        
        self.proximity = beacon.proximity
    }
}



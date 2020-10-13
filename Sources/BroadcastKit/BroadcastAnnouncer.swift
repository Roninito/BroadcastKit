//
//  Announcer.swift
//  Starborn
//
//  Created by leerie simpson on 4/18/19.
//  Copyright © 2019 leerie simpson. All rights reserved.
//

import Foundation


/// An object capable of announcing a GameEvent.
public protocol BroadcastAnnouncer: class {
    var announcing: Broadcasts { get }
    func announce(_ event: Broadcast, message: Any?)
}


public extension BroadcastAnnouncer {
    func announce(_ event: Broadcast, message: Any?) {
        if self.announcing.contains(event) {
            Broadcasting.station.post(event: event, from: self, with: message)
        }
        else {
            fatalError("Broadcast Violation: An object attempted to announce an unregistered broadcast.")
        }
    }
    
    
    func registerBroadcastingAnnouncements() {
        if announcing.count == 0 { return }
        Broadcasting.queue.async {
            if Broadcasting.station.announcers.filter({
                anoun -> Bool in
                anoun === self
            }).count <= 0 {
                Broadcasting.station.announcers.append(self)
            }
        }
    }
    
    
    func unregisterBroadcastingAnnouncements() {
        Broadcasting.queue.async {
            print("\(Broadcasting.station.announcers.count) Announcement(s) will be unregistered...", terminator: "")
            Broadcasting.station.announcers.removeAll {
                obs -> Bool in
                return obs === self
            }
            print("done.")
        }
    }
}

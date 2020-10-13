//
//  Reactor.swift
//  Starborn
//
//  Created by leerie simpson on 4/18/19.
//  Copyright © 2019 leerie simpson. All rights reserved.
//

import Foundation

/**
 An object that is capable of observing and receiving GameEvent dispatches from the EventDispatcher.
*/
public protocol BroadcastObserver: class {
    var observing: Broadcasts { get }
    func receiving(event: Broadcast, from announcer: BroadcastAnnouncer, context: Any?)
}



public extension BroadcastObserver {
    
    /**
     Internally used to determine if an event is authorized to be received by this observer.
    */
    func isValidAnnouncement(event: Broadcast) -> Bool {
        return observing.contains(event)
    }
    
    
    /**
     Allows the observer to recieve a GameAnnoucement.
    */
    func receive(announcement: EventAnnouncement) {
        if isValidAnnouncement(event: announcement.event) {
            receiving(event: announcement.event,
                      from: announcement.announcer,
                      context: announcement.context as Any?)
        }
    }
    
    
    /**
     Registers this Observer for game event dispatches.
    */
    func registerBroadcastingObservations() {
        if observing.count == 0 { return }
        Broadcasting.queue.async {
            Broadcasting.station.observers.append(self)
        }
//        print("Observer: \(self) \n\t registered to observe: \(observing)")
    }
    
    
    /**
     Unregisters this Observer from game event dispatches.
    */
    func unregisterBroadcastingObservations() {
        Broadcasting.queue.async {
            Broadcasting.station.observers.removeAll {
                obs -> Bool in
                return obs === self
            }
//            print("Observer: \(self) \n\t Unregistered from observing: \(self.observing)")
        }
    }
}

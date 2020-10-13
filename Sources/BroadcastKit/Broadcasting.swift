//
//  Dispatcher.swift
//  Starborn
//
//  Created by leerie simpson on 4/18/19.
//  Copyright © 2019 leerie simpson. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import Combine

/// Extend this struct with `static let keyName: Key = "domain.key"` to add cases
public struct Broadcast: Broadcastable {
    public var rawValue: String
    public init(rawValue: String) { self.rawValue = rawValue }
    
}


public struct EventAnnouncement {
    public let announcer: BroadcastAnnouncer
    public let event: Broadcast
    public let context: Any?
}


/**
 Manages the registration of announcements and observations and facilitates the dispatching of announcements to observations. This object supports the ObservableObject protocol from the Combine.framework and can has published obervers, announcers and announcement lists available.
 */
public class Broadcasting: ObservableObject {
    
    internal static let queue = DispatchQueue(label: "BroadcasterKit Event Dispatcher")
    public static let station = Broadcasting()
    
    @Published var observers = [BroadcastObserver?]()
    @Published var announcers = [BroadcastAnnouncer?]()
    @Published var announcements = [EventAnnouncement]()
    
    
    /**
    This allows broadcasting without the component but maybe inefficient. If the scene has a GameEventDispatchingComponent then this should be turned off to enable frame based dispatching of all events at the same time.
    */
    @Published public var perPostBroadcasting = true
    
    
    public func post(event: Broadcast, from announcer: BroadcastAnnouncer, with context: Any?) {
        Broadcasting.queue.async {
            print("""
                
                Announcing: \(event.rawValue)
                PostedBy: \(type(of: announcer) )
                Queue: \(Broadcasting.queue.label)
                Payload: \(String(describing: context))
                """)
            self.announcements.append((EventAnnouncement(announcer: announcer, event: event, context: context)))
            if self.perPostBroadcasting == true { self.broadcast() }
        }
    }
    
    
    /**
    On the broadcasting queue deliver announcements collected per frame to resistered observers.
     */
    func broadcast() {
        Broadcasting.queue.async {
            self.announcements.forEach { announcement in
                // filter out the nil observers before filtering the listerners for this announcement event.
                let registeredListeners = self.observers.compactMap({ element in
                    return element
                }).filter({ observer in
                    return observer.observing.contains(announcement.event)
                })
                registeredListeners.forEach({ listener in
                    DispatchQueue.main.async {
                        (listener).receive(announcement: announcement)
                    }
                })
            }
            self.announcements.removeAll()
        }
    }
}

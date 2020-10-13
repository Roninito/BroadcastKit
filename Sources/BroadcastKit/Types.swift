//
//  File.swift
//  
//
//  Created by leerie simpson on 10/13/20.
//

import Foundation
import GameplayKit


/// Used to represent objects that announce and observe game events.
public typealias Broadcaster = BroadcastAnnouncer & BroadcastObserver


/// Used by components on declaration so that we can provide a reaction to events when creating the GameEventListenerComponent.
public typealias EventReaction = (GKEntity, GKComponent, Broadcast, BroadcastAnnouncer, Any?) -> ()


public typealias Broadcasts = Set<Broadcast>

//
//  MessageBubble.swift
//  RoomeaseMessaging
//
//  Created by Anthony Stem on 11/2/23.
//

import Foundation

struct MessageModel: Codable, Equatable, Identifiable {
    var id: String
    var group_id: String
    var sender: String
    var text: String
    var received: Bool
    var timestamp: Date
    var pinned: Bool
}

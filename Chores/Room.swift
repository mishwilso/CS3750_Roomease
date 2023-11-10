//
//  Room.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/17/23.
//

import SwiftUI

struct Room : Identifiable {
    var id = UUID()
    var name: String
    var chores: [Chore] = []
}

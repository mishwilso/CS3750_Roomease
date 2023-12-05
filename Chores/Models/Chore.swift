//
//  Chore.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/20/23.
//

import SwiftUI

struct Chore: Identifiable, Codable {
    var id: String?
    var choreName: String
    var doneDate: String
    var roommate: String 
}

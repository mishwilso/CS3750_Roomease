//
//  Chore.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/20/23.
//

import SwiftUI

struct Chore{
    var id = UUID()
    var choreName: String
    var doneDate: String
    var numDaysReoccuring: Int = 0
    var roommate: String = "Anyone"
}


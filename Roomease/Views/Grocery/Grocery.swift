//
//  Grocery.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/17/23.
//

import SwiftUI

enum GroceryCategory: String, CaseIterable {
    case fruits
    case vegetables
    case dairy
    case grains
    case protein
    case dessert
}

struct Grocery : Identifiable {
    var id = UUID()
    var name: String
    var roommate: String = "All"
    var category: GroceryCategory
}

//test
let testList  = [Grocery(name: "carrot", roommate: "Bob", category: .vegetables), Grocery(name: "banana", roommate: "John", category: .fruits), Grocery(name: "blueberries", roommate: "Sarah", category: .fruits), Grocery(name: "milk", category: .dairy)]

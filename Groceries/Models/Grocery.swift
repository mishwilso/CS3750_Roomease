//
//  Grocery.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/17/23.
//
import Foundation

enum GroceryCategory: String, CaseIterable, Codable {
    case fruits
    case vegetables
    case dairy
    case grains
    case protein
    case dessert
    case none
}

struct Grocery: Identifiable, Codable {
    let id = UUID()
    var name: String
    var roommate: String = ""
    var category: GroceryCategory
    var imageText: String?
    
}


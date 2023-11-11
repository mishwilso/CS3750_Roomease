//
//  GroceriesFireViewModel.swift
//  
//
//  Created by Daniel Kelley on 11/11/23.
//

import Foundation

class GroceriesFireViewModel: ObservableObject {
    
    @Published var item = ""
    @Published var purpose = ""
    @Published var store = ""
    
    func addGrocery() async throws {
        print("Attempting to add Grocery")
        
        try await AuthService.shared.addGrocery(item: item, purpose: purpose, store: store)
    }
    
    func deleteGrocery() async throws {
        print("Attempting to delete Grocery")
        
        try await AuthService.shared.deleteGrocery(item: item)
    }
    
    func gettheGroceries() async throws {
        print("Attempting to get Groceries")
        
        try await AuthService.shared.getGroceries()
    }
}

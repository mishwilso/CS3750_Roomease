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
    
    func deleteGrocery() {
        print("Attempting to delete Grocery")
        
        AuthService.shared.deleteGrocery(item: item) { error in
            if let error = error {
                print("Error deleting grocery: \(error.localizedDescription)")
            }
            
            else {
                print("Grocery deleted successfully")
            }
        }
    }
    
}

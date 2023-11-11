//
//  GroceryArrayViewModel.swift
//  
//
//  Created by Daniel Kelley on 11/11/23.
//

import Foundation

class GroceryArrayViewModel: ObservableObject {
    
    @Published var groceries: [[String: Any]] = []
    
    func getTheGroceries() {
        print("Attempting to get groceries array")
        
        AuthService.shared.getGroceries { [weak self] (groceries, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting the Groceries: \(error)")
            }
            
            else if let groceries = groceries {
                self.groceries = groceries
            }
            
            else {
                print("No groceries present")
            }
        }
    }
}

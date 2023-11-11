//
//  ChoresArrayViewModel.swift
//  
//
//  Created by Daniel Kelley on 11/11/23.
//

import Foundation

class ChoresArrayViewModel: ObservableObject {
    
    @Published var chores: [[String: Any]] = []
    
    func getTheChores() {
        print("Attempting to get chores")
        
        AuthService.shared.getChores { [weak self] (chores, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting the Chores: \(error)")
                
            }
            
            else if let chores = chores {
                self.chores = chores
            }
            
            else {
                print("No chores present")
            }
        }
        
    }
}

//
//  ChoresViewModel.swift
//  
//
//  Created by Daniel Kelley on 11/7/23.
//

import Foundation

class ChoresViewModel: ObservableObject {
    
    @Published var task = ""
    @Published var frequency = ""
    @Published var deadline = ""
    
    func addChore() async throws {
        print("Attempting add Chore")
        
        try await AuthService.shared.addChore(task: task, frequency: frequency, dealine: deadline)
    }
    
    func deleteChore() async throws {
        print("Attempting to delete Chore")
        
        try await AuthService.shared.deleteChore(task: task)
        
    }
    
    func gettheChores() async throws {
        print("Attempting to get Chores")
        
        try await AuthService.shared.getChores()
    }
}

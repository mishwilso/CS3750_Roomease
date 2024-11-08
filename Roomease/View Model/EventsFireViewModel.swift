//
//  EventsFireViewModel.swift
//  
//
//  Created by Daniel Kelley on 11/11/23.
//

import Foundation

class EventsFireViewModel: ObservableObject {
    
    @Published var endTime = ""
    @Published var day = 0
    @Published var month = 0
    @Published var startTime = ""
    @Published var title = ""
    @Published var year = 0
    
    func addEvent() async throws {
        print("Attempting to add Event")
        
        try await AuthService.shared.addEvent(day: day, endTime: endTime, month: month, startTime: startTime, title: title, year: year)
    }
    
    func deleteEvent() async throws {
        print("Attempting to delete Event")
        
        AuthServide.shared.deleteEvent(title: title) {error in
            if let error = error {
                print("Error deleting event: \(error.localizedDescription)")
            }
            
            else {
                print("Event successfully deleted")
            }
        }
    }
    
}

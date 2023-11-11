//
//  EventsFireViewModel.swift
//  
//
//  Created by Daniel Kelley on 11/11/23.
//

import Foundation

class EventsFireViewModel: ObservableObject {
    
    @Published var endTime = ""
    @Published var dat = 0
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
        
        try await AuthService.shared.deleteEvent(title: title)
    }
    
    func gettheEvents() async throws {
        print("Attempting to get Events")
        
        try await AuthService.shared.getEvents()
    }
}

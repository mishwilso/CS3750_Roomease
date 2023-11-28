//
//  EventsArrayViewModel.swift
//  
//
//  Created by Daniel Kelley on 11/11/23.
//

import Foundation

class EventsArrayViewModel: ObservableObject {
    
    @Published var events: [[String: Any]] = []
    
    func getTheEvents() {
        print("Attempting to get events.")
        
        AuthService.shared.getEvents {[weak self] (events, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting the events: \(error)")
            }
            
            else if let events = events {
                self.events = events
            }
            
            else {
                print("No events found.")
            }
        }
    }
}

//
//  DeleteEventView.swift
//  Roomease
//
//  Created by Molly Pate on 12/3/23.
//

import SwiftUI

struct DeleteEventView: View {
    @Binding var event : Event
    @Binding var deleteEvent: Bool

    var body: some View {
        VStack {
            
            Button("Back") {
                deleteEvent = false
            }
            Text("Event Information: ")
            
            Text(event.title)
            Text("Starts: \(event.startDate.formatted(date: .abbreviated, time: .standard))")
            Text("Ends: \(event.endDate.formatted(date: .abbreviated, time: .standard))")
            Button("Delete Event") {
                Task {
                    do {
                        try await deleteEvent(event: event)
                    }
                    catch {
                        print(error)
                    }
                }
                deleteEvent = false
            }
        }
    }
    func deleteEvent(event: Event) async {
        let calendarManager = await CalendarManager()
        let eventIdToDelete = event.eventId
        await calendarManager.deleteEvent(eventId: eventIdToDelete) { error in
            if let error = error {
                print("Error deleting event: \(error.localizedDescription)")
            } else {
                print("Event deleted successfully")
            }
        }
    }
}

//#Preview {
//    DeleteEventView()
//}

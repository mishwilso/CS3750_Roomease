//
//  CalenderViewModel.swift
//  Roomease
//
//  Created by user247737 on 11/15/23.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Event: Codable {
    var title: String
    var description: String
    var startDateTime: Date
    var endDateTime: Date
    var eventId: String // <-- to get the eventId| var eventId = RandomIdGenerator.getBase62(length: 10) | so we have something unique to identify the events uniquely :)
    // Add any other properties as needed
}

class CalendarManager {
    let db = Firestore.firestore()
    var eventIds: [String: String] = [:]
    
    init() async {
        // Call an asynchronous method to get the grocery IDs
        await fetchEventIds()
    }

    // Define an asynchronous method to fetch grocery IDs
    private func fetchEventIds() async {
        let ids = await AuthService.shared.getIdList(listName: "eventIds")
        eventIds = ids
    }
    
    func createCalendar(name: String, ownerId: String) async {
        
        let calendarId = await AuthService.shared.getGroupId()
        
            let calendarData: [String: Any] = [
                "name": name,
                "ownerId": ownerId
                // Add other things if you need them :)
            ]

        db.collection("Calendars").document(calendarId).setData(calendarData) { error in
                if let error = error {
                    print("Error creating calendar: \(error.localizedDescription)")
                } else {
                    print("Calendar successfully created with ID: \(String(describing: calendarId))")

                    // Create the 'events' subcollection within the calendar document
                    let eventsCollectionRef = self.db.collection("Calendars").document(calendarId).collection("events")
                    //await self.createInitialEvents(eventsCollectionRef: eventsCollectionRef)
                }
            }
        }

        private func createInitialEvents(eventsCollectionRef: CollectionReference) async {
            // You can add initial events or perform any other actions related to the 'events' subcollection here
            // For example, you might want to add default events when a calendar is created
            var eventId = RandomIdGenerator.getBase62(length: 10)
                
            let initialEvent1 = Event(title: "Meeting", description: "Team Meeting", startDateTime: Date(), endDateTime: Date(), eventId: eventId)
            do {
                let eventRef = try eventsCollectionRef.addDocument(from: initialEvent1)
                print("Added initial event with ID: \(eventRef.documentID)")
                eventIds[initialEvent1.eventId] = eventRef.documentID
                try await AuthService.shared.updateIdList(listName: "eventIds", newList: eventIds)
            } catch {
                print("Error adding initial event: \(error.localizedDescription)")
            }

        }
    

    func addEvent(event: Event, completion: @escaping (Error?) -> Void) async {
        let calendarId = await AuthService.shared.getGroupId()
        do {
            let eventRef = try db.collection("Calendars").document(calendarId).collection("events").addDocument(from: event)
            print("Added event with ID: \(eventRef.documentID)")
            eventIds[event.eventId] = eventRef.documentID
            try await AuthService.shared.updateIdList(listName: "eventIds", newList: eventIds)
            completion(nil)
        } catch {
            print("Error adding event: \(error.localizedDescription)")
            completion(error)
        }
    }

    func deleteEvent(eventId: String, completion: @escaping (Error?) -> Void) async {
        let calendarId = await AuthService.shared.getGroupId()
        
        // Get choreId using choreName
        guard let eventRef = eventIds[eventId] else {
            print("Chore not found")
            completion(nil) // Or you can pass an error, I haven't figured out how to do that yet tho :/
            return
        }
        
        db.collection("Calendars").document(calendarId).collection("events").document(eventRef).delete { error in
            if let error = error {
                print("Error deleting event: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Event successfully deleted")
                completion(nil)
            }
        }
        do {
            try await AuthService.shared.updateIdList(listName: "eventIds", newList: eventIds)
        } catch {
            print("Failed to update ID list")
        }
    }

    func getEvents(calendarId: String, completion: @escaping ([Event]?, Error?) -> Void) async {
        let calendarId = await AuthService.shared.getGroupId()
        db.collection("Calendars").document(calendarId).collection("events").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
                completion(nil, error)
            } else {
                let events = snapshot?.documents.compactMap { document -> Event? in
                    try? document.data(as: Event.self)
                }
                completion(events, nil)
            }
        }
    }
}




///How to Call the Functions:
///// Call the createCalendar function --> This is done in the Household creation so don't worry about it too much
//calendarManager.createCalendar(calendarId: calendarId, name: householdName, ownerId: ownerId -> user who made the household)

// ## Add an event to the calender
// ## Uses the Event Codable :) if there needs to be more things let me know.
// let event = Event(title: "Meeting", description: "Team Meeting", startDateTime: Date(), endDateTime: Date())
// calendarManager.addEvent(event: event) { error in
//    if let error = error {
//        #You can use this to catch errors, and print something on the screen to say the event wasn't added properly :)
//        print("Error adding event: \(error.localizedDescription)")
//    } else {
//        print("Event added successfully")
//    }
// }

// ## Retrieve events for a calendar
//calendarManager.getEvents() { events, error in
//    if let error = error {
//        print("Error getting events: \(error.localizedDescription)")
//    } else {
//        if let events = events {
//            print("Events for calendar \(calendarId):")
//            for event in events {
//               #You can access the different parts of an event like this-> so it's very modifiable :)
//                print("\(event.title) - \(event.startDateTime) to \(event.endDateTime)")
//            }
//        } else {
//            print("No events found for calendar \(calendarId)")
//        }
//    }
//}

// Delete an event
//let eventIdToDelete = "random unique generated code"
//calendarManager.deleteEvent(eventId: eventIdToDelete) { error in
//    if let error = error {
//        print("Error deleting event: \(error.localizedDescription)")
//    } else {
//        print("Event deleted successfully")
//    }
//}

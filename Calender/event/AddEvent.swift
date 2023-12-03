//
//  AddEvent.swift
//  Roomease
//
//  Created by Molly Pate on 11/10/23.
//

import SwiftUI

struct AddEvent: View {
    @State private var eventTitle: String = ""
    @State private var date = Date()
    @State private var startDate : Date = Date()
    @State private var endDate : Date = Date()
    @Binding var addEvent: Bool
    //@StateObject var eventsFireViewModel = EventsFireViewModel()

    
    
    //@State private var date: Date
    var body: some View {
        // control buttons
        HStack (alignment: .top, spacing: 200) {
            Button("Cancel") {
                // go back to the calendar view
                addEvent = false
            }
            .buttonStyle(BorderlessButtonStyle())
            .frame(alignment: .leading)
            
            Button("Add") {
                // save the information and go back to the calendar view
//                let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
//                let startComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: startDate)
//                let endComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: endDate)
                

                // add event
                // TODO: hookup to firebase here!!
                Task {
                        do {
                            if endDate < startDate {
                                endDate = startDate
                            }
                            try await addEventToCal(title: eventTitle, startDate: startDate, endDate: endDate)
                            addEvent = false
                        }
                        catch {
                            print(error)
                            addEvent = false
                        }
                    }
                addEvent = false
            }
            .buttonStyle(BorderlessButtonStyle())
            
        }
        

        VStack (alignment: .center, spacing: 20){
           
            // get the event title
            TextField(
                "Event title",
                text: $eventTitle
            )
            .frame(alignment: .center)
            .border(Color.black, width: 1)
            
            // get the date of the event (just one day right now)
            
            
            // get the start time
            DatePicker(selection: $startDate, displayedComponents: [.date, .hourAndMinute]) {
                Text("Starts")
            }
            
            // get the end time
            DatePicker(selection: $endDate, in: startDate..., displayedComponents: [.date, .hourAndMinute]) {
                Text("Ends")
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment:
                .center)
        
    }
    func addEventToCal(title: String, startDate: Date, endDate: Date) async {
        let calendarManager = await CalendarManager()
        
        let eventIds = calendarManager.eventIds
        var eventId = RandomIdGenerator.getBase62(length: 10)
        while eventIds.contains(where: {eventId == $0.key}) {
            eventId = RandomIdGenerator.getBase62(length: 10)
        }
        
        
        let event = Event(title: title, startDate: startDate, endDate: endDate, eventId: eventId)
         await calendarManager.addEvent(event: event) { error in
            if let error = error {
                // You can use this to catch errors, and print something on the screen to say the event wasn't added properly :)
                print("Error adding event: \(error.localizedDescription)")
            } else {
                print("Event added successfully")
            }
         }
    }
}



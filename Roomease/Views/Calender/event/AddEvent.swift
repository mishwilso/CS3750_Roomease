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
    @State private var startTime = Date()
    @State private var endTime = Date()
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
                let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
                let startTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                let endTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
                
                let day = dateComponents.day ?? 01
                let month = dateComponents.month ?? 01
                let year = dateComponents.year ?? 2023
                let startT = "\(startTimeComponents.hour ?? 01):\(startTimeComponents.minute ?? 01)"
                let endT = "\(endTimeComponents.hour ?? 01):\(endTimeComponents.minute ?? 01)"

                // add event
                // TODO: hookup to firebase here!!
                //eventsFireViewModel.addEvent(day: day, endTime: endT, month: month, startTime: startT, title: eventTitle, year: year)

                //let month = "
                
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
            DatePicker(selection: $date, displayedComponents: [.date]) {
                Text("Date")
            }
            
            // get the start time
            DatePicker(selection: $startTime, displayedComponents: [.hourAndMinute]) {
                Text("Starts")
            }
            
            // get the end time
            DatePicker(selection: $endTime, in: startTime..., displayedComponents: [.hourAndMinute]) {
                Text("Ends")
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment:
                .center)
    }
    
}



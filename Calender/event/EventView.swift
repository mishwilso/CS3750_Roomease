// This struct represents the list of events below the calendar grid and updates based on the date selected

import SwiftUI

/*
    Visually, this is the list of events below the calendar grid
 */
struct EventView: View {
    @Binding var date: Date
    @State var todaysEvents: [Event] = []
    @State var deleteEvent = false
    var body: some View {
            VStack {
                // if there are no events for the selected date, display a message
                if todaysEvents.count == 0 {
                    ZStack {
                        // background rectangle
                        Rectangle()
                            .frame(width: 300, height: 150)
                            .cornerRadius(10)
                            .foregroundColor(lighterGray)
                        VStack (spacing: 10){
                            // the text and smiley face image
                            Text("No Scheduled Events").bold().padding().font(.system(size: 20)).foregroundColor(.black).cornerRadius(10).background(lighterGray)
                            Image(systemName: "face.smiling")
                                .foregroundColor(.gray)
                                .font(.system(size: 20))
                        }
                        
                    }
                }
                // if there are events for the selected date, display them as buttons to their expanded view (DeleteButtonView)
                else {
                    VStack (alignment: .center){
                        // iterate through the events
                        List($todaysEvents) { $event in
                            Button {
                                deleteEvent = true
                                
                            } label: {
                                // the label: title, followed by two static date pickers
                                HStack {
                                    Text("\(event.title)").bold().padding().font(.system(size: 20)).foregroundColor(.black)
                                }
                                .frame(width: 300)
                                .padding([.leading, .trailing], 10)
                                .background(bttnColor)
                                .cornerRadius(10)
                                

                                HStack (alignment: .center, spacing: 5) {
                                    Text("Starts:").bold().foregroundColor(.black)
                                    DatePicker("", selection: $event.startDate, in: event.startDate...event.startDate, displayedComponents: [.date, .hourAndMinute])
                                        .disabled(true)
                                        .padding([.trailing], 5)
                                }
                                .frame(width: 300)
                                .padding([.leading, .trailing], 10)
                                .cornerRadius(10)
                                
                                HStack (alignment: .center, spacing: 5) {
                                    Text("Ends:").bold().foregroundColor(.black)
                                    DatePicker("", selection: $event.endDate, in: event.endDate...event.endDate, displayedComponents: [.date, .hourAndMinute])
                                        .disabled(true)
                                        .padding([.trailing], 5)
                                }
                                .frame(width: 300)
                                .padding([.leading, .trailing], 10)
                                .cornerRadius(10)
                            }
                            .foregroundColor(.black)
                            .background(lighterGray)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .sheet(isPresented: $deleteEvent) {
                                // swap to the expanded event view -> DeleteEventView
                                DeleteEventView(event: $event, deleteEvent: $deleteEvent)
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
                
                
            }
            .frame(width: 500, height: 300, alignment: .center)
            // allows the page to refresh on the update of a binding variable
            .onChange(of: date) { date in
                todaysEvents.removeAll()
                Task {
                    do {
                        try await getEvents()
                    }
                    catch {
                        print(error)
                    }
                    
                }
            }
            // allows the page to update upon first visting it from another view
            .onAppear {
                todaysEvents.removeAll()
                Task {
                    do {
                        try await getEvents()
                    }
                    catch {
                        print(error)
                    }
                    
                }
            }
    }
    
    func getEvents() async {
        // remove any exisiting events
        todaysEvents.removeAll()
        
        // use the CalendarManager from CalendarViewModel
        let calendarManager = await CalendarManager()
        let eventIds = calendarManager.eventIds
        var eventId = RandomIdGenerator.getBase62(length: 10)
        while eventIds.contains(where: {eventId == $0.key}) {
            eventId = RandomIdGenerator.getBase62(length: 10)
        }
        
        // call to the backend
        await calendarManager.getEvents() { events, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
            } else {
                if let events = events {
                    for event in events {
                        let range = event.startDate ... event.endDate
                        // add the event to the list if it is in the date range inclusive
                        // NOTE: this is set up to include events that happened earlier that day as well
                        if range.contains(date) || Calendar.current.isDate(event.startDate, equalTo: date, toGranularity: .day) || Calendar.current.isDate(event.endDate, equalTo: date, toGranularity: .day){
                            todaysEvents.append(event)
                        }
                        print("\(event.title) - \(event.startDate) to \(event.endDate)")
                    }
                } else {
                    print("No events found for calendar")
                }
            }
            
            // sort the events from earliest start date to latest
            todaysEvents.sort(by: {$0.startDate < $1.startDate})
            print("\(date.formatted(date: .complete, time: .omitted))")
        }
    }
}



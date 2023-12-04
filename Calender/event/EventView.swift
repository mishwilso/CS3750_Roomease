//
//  EventView.swift
//  Roomease
//
//  Created by Molly Pate on 11/11/23.
//

import SwiftUI

struct EventView: View {
    @Binding var date: Date
    @State var todaysEvents: [Event] = []
    @State var deleteEvent = false
    var body: some View {
        // get all the events for today
        //let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
            
            
            VStack {
                if todaysEvents.count == 0 {
                    ZStack {
                        Rectangle()
                            .frame(width: 300, height: 150)
                            .cornerRadius(10)
                            .foregroundColor(lighterGray)
                        VStack (spacing: 10){
                            Text("No Scheduled Events").bold().padding().font(.system(size: 20)).foregroundColor(.gray).cornerRadius(10).background(lighterGray)
                            Image(systemName: "face.smiling")
                                .foregroundColor(.gray)
                        }
                        
                    }
//                    Text("No Scheduled Events").bold().padding().font(.system(size: 20)).foregroundColor(.gray).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/).background(lighterGray)
                }
                else {
                    VStack (alignment: .center){
                        List($todaysEvents) { $event in
                            Button {
                                deleteEvent = true
                                
                            } label: {
                                Text("\(event.title)").bold().padding().font(.system(size: 20)).foregroundColor(.gray).underline()

                                Text("Starts: \(event.startDate.formatted(date: .numeric, time: .shortened))").frame(alignment: .leading).padding()
                                Text("Ends: \(event.endDate.formatted(date: .numeric, time: .shortened))").frame(alignment: .leading).padding()
                            }
                            .foregroundColor(.black) // 2
                            .background(lighterGray) // 3
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .sheet(isPresented: $deleteEvent) {
                                DeleteEventView(event: $event, deleteEvent: $deleteEvent)
                            }
                        }
    //                    .frame(width: 500)
                        .scrollContentBackground(.hidden)
                    }
                }
                
                
            }
            .frame(width: 500, height: 300, alignment: .center)
            .onChange(of: date) { date in
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
        todaysEvents.removeAll()
        let calendarManager = await CalendarManager()
//        var calEvents : [Event] = []
        let eventIds = calendarManager.eventIds
        var eventId = RandomIdGenerator.getBase62(length: 10)
        while eventIds.contains(where: {eventId == $0.key}) {
            eventId = RandomIdGenerator.getBase62(length: 10)
        }
        
        
        await calendarManager.getEvents() { events, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
            } else {
                if let events = events {
                    for event in events {
//                       #You can access the different parts of an event like this-> so it's very modifiable :)
                        let range = event.startDate ... event.endDate
//                        print("\(date.formatted(date: .complete, time: .omitted))")
                        if range.contains(date) || Calendar.current.isDate(event.startDate, equalTo: date, toGranularity: .day) || Calendar.current.isDate(event.endDate, equalTo: date, toGranularity: .day){
                            todaysEvents.append(event)
                        }
                        print("\(event.title) - \(event.startDate) to \(event.endDate)")
                    }
                } else {
                    print("No events found for calendar")
                }
            }
            todaysEvents.sort(by: {$0.startDate < $1.startDate})
            print("\(date.formatted(date: .complete, time: .omitted))")
        }
//        return calEvents
        
        
    }
}



// This is the delete event view accessed by clicking on a particular event in the calendar view

import SwiftUI

struct DeleteEventView: View {
    @Binding var event : Event
    @Binding var deleteEvent: Bool

    var body: some View {
        
        ZStack (alignment: .center) {
            // background circles
            Ellipse()
                .frame(width: 458, height: 420)
                .padding(.trailing, -500)
                .foregroundColor(lighterGray)
                .padding(.top, -550)
            
            Ellipse()
                .frame(width: 510, height: 478)
                .padding(.leading, -200)
                .foregroundColor(lightGray)
                .padding(.top, -590)
            
            // print out the event information
            VStack (spacing: 20){
                Text(event.title).bold().padding().font(.system(size: 35)).foregroundColor(.black)
                Text("Starts: \(event.startDate.formatted(date: .abbreviated, time: .shortened))").padding().font(.system(size: 18))
                Text("Ends: \(event.endDate.formatted(date: .abbreviated, time: .shortened))").padding().font(.system(size: 18))
                
                HStack (spacing: 20) {
                    // leave the view without deleting an event
                    Button("Back") {
                        deleteEvent = false
                    }
                    .frame(width: 150, height: 75)
                    .foregroundColor(.black)
                    .background(bttnColor)
                    .cornerRadius(10)
                    .padding()
                    
                    // delete the event and leave the view
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
                    .frame(width: 150, height: 75)
                    .foregroundColor(.black)
                    .background(bttnColor)
                    .cornerRadius(10)
                    .padding()
                }
                
            }
            .cornerRadius(10)
            .padding()
            .frame(width: 350, height: 500)
        }
    }
    // delete event view using the calendar manager -> in the CalendarViewModel
    func deleteEvent(event: Event) async {
        // get a calendar manager
        let calendarManager = await CalendarManager()
        let eventIdToDelete = event.eventId
        // delete the event from firebase
        await calendarManager.deleteEvent(eventId: eventIdToDelete) { error in
            // for testing purposes
            if let error = error {
                print("Error deleting event: \(error.localizedDescription)")
            } else {
                print("Event deleted successfully")
            }
        }
    }
}


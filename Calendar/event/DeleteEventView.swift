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
        
        ZStack (alignment: .center) {
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
            
            VStack (spacing: 20){
                
                
                
                Text(event.title).bold().padding().font(.system(size: 35)).foregroundColor(.black)
                Text("Starts: \(event.startDate.formatted(date: .abbreviated, time: .shortened))").padding().font(.system(size: 18))
                Text("Ends: \(event.endDate.formatted(date: .abbreviated, time: .shortened))").padding().font(.system(size: 18))
                
                HStack (spacing: 20) {
                    Button("Back") {
                        deleteEvent = false
                    }
                    .frame(width: 150, height: 75)
                    .foregroundColor(.black) // 2
                    .background(bttnColor) // 3
                    .cornerRadius(10)
                    .padding()
                    
                    
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
                    .foregroundColor(.black) // 2
                    .background(bttnColor) // 3
                    .cornerRadius(10)
                    .padding()
                }
                
            }
            //.background(lightGray)
            .cornerRadius(10)
            .padding()
            .frame(width: 350, height: 500)
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

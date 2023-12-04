// This is the view found by clicking the "plus" button on the top right on the screen
//

import SwiftUI

struct AddEvent: View {
    @State private var eventTitle: String = ""
    @State private var date = Date()
    @State private var startDate : Date = Date()
    @State private var endDate : Date = Date()
    @Binding var addEvent: Bool

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
            
            // the add event form
            VStack (spacing: 20) {
                Text("Add New Event").bold().padding().font(.system(size: 35)).foregroundColor(.black)
                VStack (alignment: .center, spacing: 20){
                   
                    // get the event title
                    CustomTextField(placeHolder: "Event Title", bColor: textColor, tOpacity: 0.6, value: $eventTitle)
                        .padding([.bottom], 10)
                    
                    // get the date of the event (just one day right now)
                    
                    
                    // get the start time
                    DatePicker(selection: $startDate, displayedComponents: [.date, .hourAndMinute]) {
                        Text("Starts")
                    }
                    .font(.system(size: 18))
                    .accentColor(.gray)
                    
                    // get the end time
                    DatePicker(selection: $endDate, in: startDate..., displayedComponents: [.date, .hourAndMinute]) {
                        Text("Ends")
                    }
                    .font(.system(size: 18))
                    .accentColor(.gray)

                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment:
                        .center)
                
                // control buttons
                HStack (spacing: 20) {
                    Button("Cancel") {
                        // go back to the calendar view
                        addEvent = false
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(width: 150, height: 75)
                    .foregroundColor(.black)
                    .background(bttnColor)
                    .cornerRadius(10)
                    .padding()
                    
                    Button("Add") {
                        // add event and leave view
                        Task {
                                do {
                                    // update the endDate if the user didn't touch it
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
                    .frame(width: 150, height: 75)
                    .foregroundColor(.black) // 2
                    .background(bttnColor) // 3
                    .cornerRadius(10)
                    .padding()
                    
                }
            }
        }
    }
    
    // add a new event to firebase - interacts with the CalendarManager in CalendarViewModel
    func addEventToCal(title: String, startDate: Date, endDate: Date) async {
        // get a calendar manager
        let calendarManager = await CalendarManager()
        
        let eventIds = calendarManager.eventIds
        var eventId = RandomIdGenerator.getBase62(length: 10)
        while eventIds.contains(where: {eventId == $0.key}) {
            eventId = RandomIdGenerator.getBase62(length: 10)
        }
        
        // create a new event
        let event = Event(title: title, startDate: startDate, endDate: endDate, eventId: eventId)
        // add it to firebase through the manager
        await calendarManager.addEvent(event: event) { error in
            if let error = error {
                // for testing
                print("Error adding event: \(error.localizedDescription)")
            } else {
                print("Event added successfully")
            }
         }
    }
}



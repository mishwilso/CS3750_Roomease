//
//  MonthView.swift
//  test1
//
//  Created by Molly Pate on 10/18/23.
//

import SwiftUI

/*
    This is the main calendar content - the calendar grid, and the event view/list below it
 
    Inspiration was drawn from the following resources
    Used the following resources:
    https://developer.apple.com/documentation/swiftui/environmentvalues/calendar
    https://sarunw.com/posts/swiftui-tabview/
    https://codingwithrashid.com/how-to-align-vstack-items-to-top-in-ios-swiftui/
    https://www.hackingwithswift.com/forums/swiftui/creating-a-daily-view-calendar-with-overlapping-events/22436
    https://blog.logrocket.com/working-calendars-swift/#create-swift-ui-project
    https://www.swiftyplace.com/blog/tabview-in-swiftui-styling-navigation-and-more
*/
struct MonthView: View {
    @Binding var selectedDate: Date
    var body: some View {
        VStack() {
            Divider().frame(height: 1)
            // the calendar grid
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .padding()
                .datePickerStyle(.graphical)
                .accentColor(.gray)
            Divider()
            // list the events for the day here
            EventView(date: $selectedDate)
        }
        .padding()
        
    }
}

//#Preview {
//    MonthView()
//}

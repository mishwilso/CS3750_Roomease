// This is a view within CalendarContent

import SwiftUI

/*
    Oringally designed to have a month/week view, but the weekview was cut due to redundancy in the views
    Now, this view provides just some additional formatting features
    In the future, here is where we could add additional calendar views
 */
struct MonthWeekTabView: View {
    @Binding var selectedDate: Date
    @Binding var selectedIdx: Int
    var body: some View {
        TabView (selection: $selectedIdx){
            MonthView(selectedDate: $selectedDate)
                .tabItem {
                    Label("Month", systemImage: "circle.fill")
                }.tag(0)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(maxWidth: .infinity)
    }
        
}

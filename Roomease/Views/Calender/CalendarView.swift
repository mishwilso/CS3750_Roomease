//
//  ContentView.swift
//  calendar_demo
//
//  Created by Molly Pate on 10/18/23.
//

import SwiftUI

struct CalendarView: View {
    @State var selectedDate: Date = Date()
    @State var selectedIdx = 0
    @State private var addEvent : Bool = false
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    // add event nav link
                    NavigationLink(destination: AddEvent(addEvent: $addEvent) .navigationBarBackButtonHidden(true), isActive: $addEvent) {
                        Image(systemName: "plus")
                            .font(.system(size: 20))
                            .bold()
                            .padding([.trailing], 50)
                            .frame(maxWidth: .infinity, alignment:
                                    .topTrailing)
                            
                        
                    }
                    
                    // display the selected calendar view
                    MonthWeekTabView(selectedIdx: $selectedIdx)
                }
            }
            
            // display the calendar view
            
                
        }

    }
}

#Preview {
    ContentView()
}

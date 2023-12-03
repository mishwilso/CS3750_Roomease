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
            VStack {
                Button {
                    addEvent = true
                    
                } label: {
                    Image(systemName: "plus")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.trailing], 30)
                .sheet(isPresented: $addEvent) {
                    AddEvent(addEvent: $addEvent)
                }
                MonthWeekTabView(selectedDate: $selectedDate, selectedIdx: $selectedIdx)
                

            }
        }
    }
}

//#Preview {
//    CalendarView()
//}

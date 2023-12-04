//
//  ContentView.swift
//  calendar_demo
//
//  Created by Molly Pate on 10/18/23.
//

import SwiftUI

struct CalendarContentView: View {
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
                        .foregroundColor(.gray)
                }
                .font(.system(size: 20))
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

struct CalendarView: View {
    var body: some View {
        ZStack (alignment: .center) {
            ZStack {
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
            }
            .ignoresSafeArea()
            CalendarContentView()
                .padding(20)
        }
    }
}

//#Preview {
//    CalendarView()
//}

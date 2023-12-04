//
//  MonthWeekTabView.swift
//  test1
//
//  Created by Molly Pate on 10/18/23.
//

import SwiftUI

struct MonthWeekTabView: View {
    @Binding var selectedDate: Date
    @Binding var selectedIdx: Int
    var body: some View {
        TabView (selection: $selectedIdx){
            MonthView(selectedDate: $selectedDate)
                .tabItem {
                    Label("Month", systemImage: "circle.fill")
                }.tag(0)
                
//            WeekView(selectedDate: $selectedDate)
//                .tabItem {
//                    Label("Week", systemImage: "circle.fill")
//                }.tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(maxWidth: .infinity)
    }
        
}

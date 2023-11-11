//
//  MonthWeekTabView.swift
//  test1
//
//  Created by Molly Pate on 10/18/23.
//

import SwiftUI

struct MonthWeekTabView: View {
    @Binding var selectedIdx: Int
    var body: some View {
        TabView (selection: $selectedIdx){
            // display month view
            MonthView()
                .tabItem {
                    Label("Month", systemImage: "circle.fill")
                }.tag(0)
            // display week view
            WeekView()
                .tabItem {
                    Label("Week", systemImage: "circle.fill")
                }.tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(maxWidth: .infinity)
        
    }
        
}



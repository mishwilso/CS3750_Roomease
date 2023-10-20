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
            MonthView()
                .tabItem {
                    Label("Month", systemImage: "dot")
                }.tag(0)
                
            WeekView()
                .tabItem {
                    Label("Week", systemImage: "dot")
                }.tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(maxWidth: .infinity)
    }
        
}

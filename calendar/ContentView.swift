//
//  ContentView.swift
//  calendar_demo
//
//  Created by Molly Pate on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedDate: Date = Date()
    @State var selectedIdx = 0
    var body: some View {
        MonthWeekTabView(selectedIdx: $selectedIdx)        
    }
}

#Preview {
    ContentView()
}

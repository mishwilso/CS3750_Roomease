//
//  MonthView.swift
//  test1
//
//  Created by Molly Pate on 10/18/23.
//

import SwiftUI

struct MonthView: View {
    @State var selectedDate: Date = Date()
    var body: some View {
        VStack() {
            Divider().frame(height: 1)
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .padding(.horizontal)
                .datePickerStyle(.graphical)
            Divider()
        }
        .padding()    }
}

#Preview {
    MonthView()
}

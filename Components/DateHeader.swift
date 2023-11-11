//
//  DateHeader.swift
//  RoomeaseMessaging
//
//  Created by Anthony Stem on 11/11/23.
//

import SwiftUI

struct DateHeader: View {
    var headerText: String = ""
    
    var body: some View {
        HStack {
            Text(headerText)
                .font(.footnote)
                .foregroundColor(Color(red: 100 / 255, green: 100 / 255, blue: 100 / 255))
        }
        .padding(.top, 8)
        
    }
}

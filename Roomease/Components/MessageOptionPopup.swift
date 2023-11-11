//
//  MessageOptionPopup.swift
//  RoomeaseMessaging
//
//  Created by Anthony Stem on 11/3/23.
//

import SwiftUI

struct MessageOptionPopup: View {
    var body: some View {
        VStack(spacing: 0) {
            Button {
                print("Edit")
            } label: {
                Label("Edit", systemImage: "pencil.and.outline")
            }
            .frame(width: 128)
            .foregroundColor(Color.black)
            .background(Color(red: 200 / 255, green: 200 / 255, blue: 200 / 255))
            
            Divider()
                .frame(width: 128, height: 2)
                .background(Color.black)
            
            
            Button {
                print("Pin")
            } label: {
                Label("Pin", systemImage: "pin")
            }
            .frame(width: 128)
            .foregroundColor(Color.black)
            .background(Color(red: 200 / 255, green: 200 / 255, blue: 200 / 255))
            
            Divider()
                .frame(width: 128, height: 2)
                .background(Color.black)
            
            
            Button {
                print("Delete")
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .frame(width: 128)
            .foregroundColor(Color.black)
            .background(Color(red: 200 / 255, green: 200 / 255, blue: 200 / 255))
        }
    }
}


struct MessageOptionPopup_previews: PreviewProvider {
    static var previews: some View {
        MessageOptionPopup()
    }
}

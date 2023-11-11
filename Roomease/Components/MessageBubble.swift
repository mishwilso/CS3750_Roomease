//
//  MessageBubble.swift
//  RoomeaseMessaging
//
//  Created by Anthony Stem on 11/2/23.
//

import SwiftUI

struct MessageBubble: View {
    @State private var isLongPressed: Bool = false
    var message: MessageModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: "person.fill")
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(64)
                Text(verbatim: message.sender)
                    .fontWeight(.bold)
                Spacer()
                Text(message.timestamp.formatted(.dateTime.hour().minute()))
                    .font(.footnote)
                    .foregroundColor(Color(red: 100 / 255, green: 100 / 255, blue: 100 / 255))
            }
            
            HStack() {
                Text(verbatim: message.text)
            }
        }
        .padding()
        .background(Color(red: 200 / 255, green: 200 / 255, blue: 200 / 255))
        .cornerRadius(4)
        .onTapGesture {
            print("Tapped")
            // For future implementation.
            // Use @State bool var if you want to do something.
        }
        .onLongPressGesture(minimumDuration: 1) {
            print("Long Press Gesture")
            isLongPressed = true
        }
        .sheet(isPresented: $isLongPressed) {
            MessageOptionPopup()
                .presentationDetents([.height(240)])
                .presentationDragIndicator(.visible)
        }
        .padding(.horizontal, 8)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: MessageModel(id: "1", group_id: "5000", sender: "Anthony Stem", text: "This is an example chat message being sent to me! This one is a longer test message that takes up a lot of space.", received: true, timestamp: Date(), pinned: false))
        MessageBubble(message: MessageModel(id: "2", group_id: "5000", sender: "Emma O'Brien", text: "This is an example chat message that I sent out!", received: false, timestamp: Date(), pinned: false))
    }
}

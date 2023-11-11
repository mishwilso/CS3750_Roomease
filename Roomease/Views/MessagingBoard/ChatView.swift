//
//  ChatView.swift
//  RoomeaseMessaging
//
//  Created by Anthony Stem on 11/2/23.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Group Chat")
                .padding(.bottom)
                .frame(maxWidth: .infinity)
                .background(Color(red: 103/255, green: 172/255, blue: 71/255))
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .font(.title)
            
            ScrollView {
                ForEach(Array(chatViewModel.chatMessages.enumerated()), id: \.1.id) { (index, message) in
                    if index == 0 || !Calendar.current.isDate(message.timestamp, equalTo: self.chatViewModel.chatMessages[index - 1].timestamp, toGranularity: .day) {
                        if Calendar.current.isDateInToday(message.timestamp) {
                            DateHeader(headerText: "Today")
                        } else if Calendar.current.isDateInYesterday(message.timestamp) {
                            DateHeader(headerText: "Yesterday")
                        } else {
                            DateHeader(headerText: message.timestamp.formatted(.dateTime.month().day().year()))
                        }
                    }
                    
                    MessageBubble(message: message)
                }
                .padding(.top, 8)
            }
            .padding(.bottom, 16)

            MessageInputField()
                .environmentObject(chatViewModel)
        }
        .padding(.bottom, 16)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

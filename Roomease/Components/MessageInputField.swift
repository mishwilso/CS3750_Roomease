//
//  MessageInputField.swift
//  RoomeaseMessaging
//
//  Created by Anthony Stem on 11/2/23.
//

import SwiftUI

struct MessageInputField: View {
    @EnvironmentObject var chatViewModel: ChatViewModel
    @State var inputText: String = ""
    @State var fieldIsSelected: Bool = false
    var body: some View {
        HStack(alignment: .center) {
            CustomMessageField(placeholder: Text("Enter a message..."), inputText: $inputText)
            
            Button { Task {
                await chatViewModel.sendMessage(group_id: "5000", sender: "Anthony Stem", text: inputText, received: false, pinned: false)
                inputText = ""
            }
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color.black)
            }
            .padding()
            .background(Color(red: 255 / 255, green: 212 / 255, blue: 22 / 255))
            .cornerRadius(64)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(red: 220 / 255, green: 220 / 255, blue: 220 / 255))
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }
}

struct MessageInputField_previews: PreviewProvider {
    static var previews: some View {
        MessageInputField()
    }
}

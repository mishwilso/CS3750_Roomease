//
//  ChatViewModel.swift
//  RoomeaseMessaging
//
//  Created by Anthony Stem on 11/2/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatViewModel: ObservableObject {
    @Published private(set) var chatMessages: [MessageModel] = []
    @Published private(set) var mostRecentChatMessageID: String = ""
    let db = Firestore.firestore()
    
    init() {
        Task.init {
            await self.getChatMessages()
        }
    }
    
    func getChatMessages() async {
        await AuthService.shared.getChatMessages {updatedMessages, updatedMostRecentID in
            self.chatMessages = updatedMessages
            self.mostRecentChatMessageID = updatedMostRecentID
        }
    }
    
    func sendMessage(group_id: String, sender: String, text: String, received: Bool, pinned: Bool) async {
        await AuthService.shared.sendMessage(group_id: group_id, sender: sender, text: text, received: received, pinned: pinned)
    }
}

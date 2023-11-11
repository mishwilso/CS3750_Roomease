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
        getChatMessages()
    }
    
    func getChatMessages() {
        db.collection("ChatMessages").addSnapshotListener { documentSnapshot, error in
            guard let documents = documentSnapshot?.documents else {
                print("Error fetching chat messages.")
                return
            }
            
            self.chatMessages = documents.compactMap { document -> MessageModel? in
                do {
                    return try document.data(as: MessageModel.self)
                } catch {
                    print("Could not decode document into ChatMessage.")
                    return nil
                }
            }
            
            self.chatMessages.sort {
                $0.timestamp > $1.timestamp
            }
            
            if let mostRecentMessageID = self.chatMessages.first?.id {
                self.mostRecentChatMessageID = mostRecentMessageID
            }
        }
    }
    
    func sendMessage(group_id: String, sender: String, text: String, received: Bool, pinned: Bool) {
        if text == "" {
            return
        }
        
        do {
            let newMessage = MessageModel(id: "\(UUID())", group_id: group_id, sender: sender, text: text, received: received, timestamp: Date(), pinned: pinned)
            
            try db.collection("ChatMessages").document().setData(from: newMessage)
        } catch {
            print("Error adding chat message to Firestore database.")
        }
    }
}

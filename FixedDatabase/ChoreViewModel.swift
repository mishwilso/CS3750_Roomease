//
//  ChoreViewModel.swift
//  Roomease
//
//  Created by user247737 on 11/15/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Room: Identifiable, Codable {
    var id: String?
    var name: String
    var chores: [Chore] = []
}

struct Chore: Identifiable, Codable {
    var id: String?
    var choreName: String
    var doneDate: String
    var numDaysReoccuring: Int = 0
    var roommate: String = "Anyone"
}


//How to get roomId
//if let roomId = choreManager.roomIds["Kitchen"] {
//    print("Room ID for Kitchen: \(roomId)")

class ChoreManager {
    let db = Firestore.firestore()
    var roomIds: [String: String] = [:]
    var choreIds: [String: String] = [:]
    
    init() async {
        // Call an asynchronous method to get the grocery IDs
        await fetchRoomIds()
    }

    // Define an asynchronous method to fetch grocery IDs
    private func fetchRoomIds() async {
        var ids = await AuthService.shared.getIdList(listName: "roomIds")
        roomIds = ids
        
        ids = await AuthService.shared.getIdList(listName: "choreIds")
        choreIds = ids
        
    }


    func addChore(roomName: String, chore: Chore, completion: @escaping (Error?) -> Void) async {
        let choreListId = await AuthService.shared.getGroupId()
        if let roomId = self.roomIds[roomName] {
            do {
                let choreRef = try db.collection("ChoresCollection").document(choreListId).collection("Rooms").document(roomId).collection("Chores").addDocument(from: chore)
                print("Added chore with ID: \(choreRef.documentID)")
                
                // Updates the dictionary with the new chore information
                choreIds[chore.choreName] = choreRef.documentID
                try await AuthService.shared.updateIdList(listName: "choreIds", newList: choreIds)
                completion(nil)
            } catch {
                print("Error adding chore: \(error.localizedDescription)")
                completion(error)
            }
        }
    }

    func removeChore(roomName: String, choreName: String, completion: @escaping (Error?) -> Void) async {
        let choreListId = await AuthService.shared.getGroupId()
        
        // Get choreId using choreName
        guard let choreId = choreIds[choreName] else {
            print("Chore not found")
            completion(nil) // Or you can pass an error, I haven't figured out how to do that yet tho :/
            return
        }
        
        
        if let roomId = self.roomIds[roomName] {
            db.collection("ChoresCollection").document(choreListId).collection("Rooms").document(roomId).collection("Chores").document(choreId).delete { error in
                if let error = error {
                    print("Error removing chore: \(error.localizedDescription)")
                    completion(error)
                } else {
                    print("Chore successfully removed")
                    completion(nil)
                }
            }
        }
        
        choreIds.removeValue(forKey: choreName)
        
        do {
            try await AuthService.shared.updateIdList(listName: "choreIds", newList: choreIds)
        } catch {
            print("Failed to update ID list")
        }
    }

    func addRoom(roomName: String, completion: @escaping (Error?) -> Void) async {
        let choreListId = await AuthService.shared.getGroupId()
        var room = Room(name: roomName)
        do {
            let roomRef = try db.collection("ChoresCollection").document(choreListId).collection("Rooms").addDocument(from: room)
            room.id = roomRef.documentID
            
            roomIds[roomName] = room.id
            try await AuthService.shared.updateIdList(listName: "roomIds", newList: roomIds)
            completion(nil)
        } catch {
            print("Error adding room: \(error.localizedDescription)")
            completion(error)
        }
    }

    func getRoom(roomName: String, completion: @escaping (Room?, Error?) -> Void) async {
        let choreListId = await AuthService.shared.getGroupId()
        if let roomId = self.roomIds[roomName] {
            db.collection("ChoresCollection").document(choreListId).collection("Rooms").document(roomId).getDocument { snapshot, error in
                if let error = error {
                    print("Error getting room: \(error.localizedDescription)")
                    completion(nil, error)
                } else {
                    if let roomData = snapshot?.data(),
                       let room = try? JSONDecoder().decode(Room.self, from: JSONSerialization.data(withJSONObject: roomData)) {
                        var decodedRoom = room
                        decodedRoom.id = snapshot?.documentID
                        completion(decodedRoom, nil)
                    } else {
                        completion(nil, nil) // Decoding error
                    }
                }
            }
        } else {
            print("Room not found")
        }
        
    }
}

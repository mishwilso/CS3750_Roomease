//
//  ChoreViewModel.swift
//  Roomease
//
//  Created by user247737 on 11/15/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class ChoreManager: ObservableObject {
    let db = Firestore.firestore()
    var roomIds: [String: String] = [:]
    var choreIds: [String: String] = [:]
    @Published private(set) var rooms: [Room] = []
    @Published private(set) var currentChores: [Chore] = []
    
    init() {
        Task.init {
            // Call an asynchronous method to get the grocery IDs
            await getAllRooms()
            await fetchRoomIds()
        }
    }
    
    // Define an asynchronous method to fetch grocery IDs
    private func fetchRoomIds() async {
        var ids = await AuthService.shared.getIdList(listName: "roomIds")
        self.roomIds = ids
        
        ids = await AuthService.shared.getIdList(listName: "choreIds")
        self.choreIds = ids
    }
    
    func addChore(roomName: String, choreName: String, roommate: String, choreDay: String, completion: @escaping (Error?) -> Void) async {
        let choreListId = await AuthService.shared.getGroupId()
        await fetchRoomIds()
        
        if let roomId = self.roomIds[roomName] {
            do {
                let choreRef = try db.collection("ChoresCollection").document(choreListId).collection("Rooms").document(roomId).collection("Chores").document()
                let chore = Chore(id: choreRef.documentID, choreName: choreName, doneDate: choreDay, roommate: roommate)
                try db.collection("ChoresCollection").document(choreListId).collection("Rooms").document(roomId).collection("Chores").document(choreRef.documentID).setData(from: chore)
                                                                                                                                           
                print("Added chore")
                
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
        await fetchRoomIds()
        
        // Get choreId using choreName
        guard let choreId = choreIds[choreName] else {
            print("Chore not found")
            completion(nil) // Or you can pass an error, I haven't figured out how to do that yet tho :/
            return
        }
        guard let roomId = roomIds[roomName] else {
            print("Grocery not found")
            completion(nil) // Or you can pass an error indicating that the grocery was not found
            return
        }
        db.collection("ChoresCollection").document(choreListId).collection("Rooms").document(roomId).collection("Chores").document(choreId).delete { error in
            if let error = error {
                print("Error removing chore: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Chore successfully removed")
                completion(nil)
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
        do {
            let choreListId = await AuthService.shared.getGroupId()
            let roomRef = try db.collection("ChoresCollection").document(choreListId).collection("Rooms").document()
            let room = Room(id: roomRef.documentID, name: roomName)
            try db.collection("ChoresCollection").document(choreListId).collection("Rooms").document(roomRef.documentID).setData(from: room)
            //can't find it without fetching again?
            await fetchRoomIds()
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
        //newly created room can't be found if I dont call fetchRoomIds
        await fetchRoomIds()
        if let roomId = self.roomIds[roomName] {
            db.collection("ChoresCollection").document(choreListId).collection("Rooms").document(roomId).collection("Chores")
                .addSnapshotListener { documentSnapshot, error in
                    guard let documents = documentSnapshot?.documents else{
                        print("Error fetching rooms")
                        return
                    }
                    
                    self.currentChores = documents.compactMap{ document -> Chore? in
                        do{
                            return try document.data(as: Chore.self)
                        } catch {
                            print("Cannot decode into room")
                            return nil
                        }
                    }
                    print(self.currentChores)
                }
        } else {
            print("Room not found")
        }
        
    }
    func getAllRooms() async {
        let houseId = await AuthService.shared.getGroupId()
        db.collection("ChoresCollection").document(houseId).collection("Rooms")
            .addSnapshotListener { documentSnapshot, error in
                guard let documents = documentSnapshot?.documents else{
                    print("Error fetching rooms")
                    return
                }
                
                self.rooms = documents.compactMap{ document -> Room? in
                    do{
                        return try document.data(as: Room.self)
                    } catch {
                        print("Cannot decode into room")
                        return nil
                    }
                }
            }
    }
}

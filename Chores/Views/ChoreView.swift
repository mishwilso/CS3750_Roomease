//
//  ChoreView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/16/23.
//

import SwiftUI
/*
    View displays the all of the rooms in the house.
 
    Click on a room to view the chores within it.
    Click on 'add custom room' to add another room.s
 */

struct ChoreView: View {
    @StateObject var choreManager = ChoreManager()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 10){
                    Text("Click on a room to view all chores").font(.title).bold()
                    ForEach(choreManager.rooms) { room in
                        NavigationLink(destination: RoomDetailView(room: room)
                            .environmentObject(choreManager)) {
                            Text(room.name)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    NavigationLink(destination: AddRoomView(newRoom: "")) {
                        Text("Add custom room")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
    func addNewRoom(roomName: String) async{
        await choreManager.addRoom(roomName: roomName) { error in
            if let error = error {
                print("Error adding event: \(error.localizedDescription)")
            } else {
                print("Room added successfully")
            }
         }
    }
}




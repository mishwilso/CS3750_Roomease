//
//  AddRoomView.swift
//  Roomease
//
//  Created by Emma O'Brien on 11/7/23.
//

import SwiftUI

struct AddRoomView: View {
    @Binding var rooms: [Room]
    @Binding var newRoom: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Add a room")
                .font(.title)
                .frame(alignment: .topLeading)
            TextField("Enter new room", text: $newRoom)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(Color.black)
                .padding()
            Button("Done") {
                if !newRoom.isEmpty {
                    addNewRoom(roomsList: &rooms, roomName: newRoom)
                    newRoom = ""
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .padding()
    }
}
func addNewRoom(roomsList: inout [Room], roomName: String){
    roomsList.append(Room(name: roomName))
    print(roomsList)
    
}

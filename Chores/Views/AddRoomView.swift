//
//  AddRoomView.swift
//  Roomease
//
//  Created by Emma O'Brien on 11/7/23.
//

import SwiftUI
/*
    View lets the user create whatever room they want.
 */

struct AddRoomView: View {
    @State var newRoom: String
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Add a room")
                .font(.title)
                .frame(alignment: .topLeading)
            TextField("Enter room name", text: $newRoom)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(Color.black)
                .padding()
            Button("Done") {
                if !newRoom.isEmpty {
                    Task{
                        await addNewRoom(roomName: newRoom)
                    }
                    //go back to previous page
                    presentationMode.wrappedValue.dismiss()
                } else{
                    showAlert = true
                }
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Missing Information"),
                      message: Text("Please enter the name of a room."),
                      dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
    func addNewRoom(roomName: String) async{
        let choreManager = ChoreManager()
        await choreManager.addRoom(roomName: roomName) { error in
            if let error = error {
                print("Error adding event: \(error.localizedDescription)")
            } else {
                print("Room added successfully")
            }
         }
    }
}


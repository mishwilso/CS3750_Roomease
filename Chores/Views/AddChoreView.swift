//
//  AddChoreView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/20/23.
//

import SwiftUI
/*
    View lets the user enter info to create a new chore in the room they have selected.
 */

struct AddChoreView: View {
    @Binding var room: Room
    @State var choreName: String
    @State var roommate: String
    @State var doneDate: String
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Add a chore")
                .font(.title)
                .frame(alignment: .topLeading)
            TextField("Enter chore", text: $choreName)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(Color.black)
                .padding()
            TextField("Enter roommate to assign chore to (or skip)", text: $roommate)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(Color.black)
                .padding()
            TextField("Enter the deadline day (day of week)", text: $doneDate)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(Color.black)
                .padding()
            
            Button("Done") {
                if !choreName.isEmpty && !doneDate.isEmpty {
                    Task{
                        if roommate.isEmpty{
                            await addChore(roomName: room.name, choreName: choreName, roommate: "Anyone", doneDate: doneDate)
                        } else {
                            await addChore(roomName: room.name, choreName: choreName, roommate: roommate, doneDate: doneDate)
                        }
                        //go back to previous page
                        presentationMode.wrappedValue.dismiss()
                    }
                } else{
                    showAlert = true
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Missing Information"),
                      message: Text("Please enter a chore name and day of the week."),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    func addChore(roomName: String , choreName: String, roommate: String, doneDate: String) async{
        let choreManager = ChoreManager()
        await choreManager.addChore(roomName: roomName, choreName: choreName, roommate: roommate, choreDay: doneDate) { error in
            if let error = error {
                print("Error adding event: \(error.localizedDescription)")
            } else {
                print("Event added successfully")
            }
         }
    }
}

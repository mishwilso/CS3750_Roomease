//
//  AddChoreView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/20/23.
//

import SwiftUI

struct AddChoreView: View {
    @Binding var room: Room
    @Binding var choreName: String
    @Binding var doneDate: String
    
    var body: some View {
        VStack {
            Text("Add a chore")
                .font(.title)
                .frame(alignment: .topLeading)
            TextField("Enter chore", text: $choreName)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(Color.black)
                .padding()
            TextField("Enter chore due date (day of week)", text: $doneDate)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(Color.black)
                .padding()
            
            Button("Done") {
                if !choreName.isEmpty && !doneDate.isEmpty {
                    addChoreToRoom(choresList: &room.chores, newChore: Chore(choreName: choreName, doneDate: doneDate))
                    choreName = ""
                    doneDate = ""
                }
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
func addChoreToRoom(choresList: inout [Chore], newChore: Chore){
    choresList.append(newChore)
}

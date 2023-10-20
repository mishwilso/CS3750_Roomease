//
//  RoomDetailView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/20/23.
//

import SwiftUI

struct RoomDetailView: View {
    @Binding var room: Room
    @State private var choreName: String = ""
    @State private var doneDate: String = ""
    
    var body: some View {
        NavigationLink(destination: AddChoreView(room: $room, choreName: $choreName, doneDate: $doneDate)) {
            Image(systemName: "plus")
        }
        
        //TODO - remove instructions
        Text("note to user: swipe to remove a chore").font(.caption)
        
        List(room.chores, id: \.id) { chore in
            HStack {
                Text(chore.choreName)
                Spacer()
                Text("due \(chore.doneDate)")
            }.swipeActions(edge: .leading, allowsFullSwipe: true) { Button("Completed") {
                removeChore(list: &room.chores, choreToRemove: chore)
            } }.tint(.green)
        }
        .navigationBarTitle(room.name)
    }
}

func removeChore(list: inout [Chore], choreToRemove: Chore){
    if let index = list.firstIndex(where: { $0.id == choreToRemove.id }) {
        list.remove(at: index)
    }
}

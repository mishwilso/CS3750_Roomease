//
//  RoomDetailView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/20/23.
//

import SwiftUI
/*
    View displays all of the chores in the room that was previously selected.
 */

struct RoomDetailView: View {
    @State var room: Room
    @EnvironmentObject var choreManager: ChoreManager
    var body: some View {
        VStack {
            NavigationLink(destination: AddChoreView(room: $room, choreName:"", roommate: "", doneDate: ""), label: {
                ZStack{
                    lightGray.frame(width: 60, height: 30).cornerRadius(10)
                    Image(systemName: "plus").foregroundColor(.blue)
                }
            }).padding(.bottom, 10)
        }
        List {
            Section(header: Text("Chores this week:")
                        .font(.subheadline)
                        .foregroundColor(.black)
            ) {
                ForEach(choreManager.currentChores, id: \.id) { chore in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(chore.choreName)
                                .font(.headline)
                            Text("Roommate: \(chore.roommate)")
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("Finish by: \(chore.doneDate)")
                            .font(.subheadline)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Completed") {
                            Task {
                                await completeChore(roomName: room.name, choreName: chore.choreName)
                            }
                        }
                        .tint(.green)
                    }
                }
            }
            .onAppear {
                Task {
                    await getChores(roomName: room.name)
                }
            }
            .navigationBarTitle(room.name)
        }


    }
    func getChores(roomName: String) async{
        await choreManager.getRoom(roomName: roomName) { chores, error in
            if let error = error {
                print("Error getting events: \(error.localizedDescription)")
            } else {
                print("Success!")
            }
        }
    }
    func completeChore(roomName: String, choreName: String) async{
        await choreManager.removeChore(roomName: roomName, choreName: choreName) { error in
            if let error = error {
                print("Error deleting chore")
            } else {
                print("Success!")
            }
        }
    }
}


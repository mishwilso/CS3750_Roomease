//
//  ChoreView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/16/23.
//

//TODO - figure out how to make chores reoccuring
//TODO - be able to assign chores to a specific roommate - connect it to their stats page if they mark it as done
//TODO - be able to create a custom room

import SwiftUI

struct ChoreView: View {
    @State var rooms: [Room] = [
        Room(name: "Kitchen"),
        Room(name: "Bathroom"),
        Room(name: "Dining room"),
        Room(name: "Living room"),
        Room(name: "Bedroom"),
        Room(name: "Custom")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                    Text("Click on a room to view all chores").font(.title).bold()
                    ForEach(rooms, id: \.id) { room in
                        NavigationLink(destination: RoomDetailView(room: $rooms.first { $0.id == room.id }!)) {
                            Text(room.name)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChoreView()
//    }
//}



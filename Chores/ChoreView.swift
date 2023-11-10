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
    ]
    @State var newRoom = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 10){
                    Text("Click on a room to view all chores").font(.title).bold()
                    ForEach($rooms) { $room in
                        NavigationLink(destination: RoomDetailView(room: $room)) {
                            Text($room.name.wrappedValue)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    NavigationLink(destination: AddRoomView(rooms: $rooms, newRoom: $newRoom)) {
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
}


struct ChoreView_Preview: PreviewProvider {
    static var previews: some View {
        ChoreView()
    }
}



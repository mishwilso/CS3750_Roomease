//
//  GroceryView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/19/23.
//

//TODO -- implement custom images to represent the food groups and have those appear on the grocery list
//TODO -- make another view that will allow groups to have multiple grocery lists

import SwiftUI

struct GroceryView: View {
    @State var groceries: [Grocery] = []
    @State var purchasedGroceries: [Grocery] = []
    @State private var addGrocery = false
    @State var roommate = ""
    @State var newGrocery = ""
    @State var selectedCategory: GroceryCategory = .fruits
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    
                    NavigationLink(destination: AddGroceryView(groceries: $groceries, newGrocery: $newGrocery, addGrocery: $addGrocery, roommate: $roommate, selectedCategory: $selectedCategory), label: {
                        ZStack{
                            
                            Text("").font(.regularFont).fontWeight(.bold).foregroundColor(.white).frame(height: 30).frame(minWidth: 0, maxWidth: 100).background(lightGray).cornerRadius(20.0)
                            Image(systemName: "plus")
                        }
                    }
                    )
                    
//                    Button(action: { addGrocery = true; print("Add Groc") }) {
//                        Image(systemName: "plus")
//                    }
//                    .buttonStyle(.bordered)
//                    .padding()
//                    
                }
                //TODO - remove instructions
                Text("note to user: swipe to remove from list or add back to list").font(.caption)
                Section(header: Text("Groceries to purchase")) {
                    List(groceries) { grocery in
                        HStack {
                            //TODO - this image should be updated with custom icon
                            Image(systemName: "fork.knife")
                            Text(grocery.name)
                            Text("(\(grocery.roommate))")
                            
                        } .swipeActions(edge: .leading, allowsFullSwipe: true) { Button("Remove") {
                            purchasedGroceries.append(grocery)
                            removeGrocery(list: &groceries, groceryToRemove: grocery)
                        } }.tint(.red)
                    }
                }
                Section(header: Text("Groceries already bought")){
                    List(purchasedGroceries) { grocery in
                        HStack {
                            //TODO - this image should be updated with the custom icons
                            Image(systemName: "bag")
                            Text(grocery.name) .strikethrough(true, color: .black)
                            Text("(\(grocery.roommate))")
                            Spacer()
                            Button(action: {removeGrocery(list: &purchasedGroceries, groceryToRemove: grocery)}) {
                                Image(systemName: "trash")
                            }.tint(.black)
                        } .swipeActions(edge: .leading, allowsFullSwipe: true) { Button("Add back") {
                            groceries.append(grocery)
                            if let index = self.purchasedGroceries.firstIndex(where: { $0.id == grocery.id }) {
                                self.purchasedGroceries.remove(at: index)
                            }
                        } } .tint(.green)
                    }
                }
            }
        }//.navigationDestination(isPresented: $addGrocery) {
//            AddGroceryView(groceries: $groceries, newGrocery: $newGrocery, addGrocery: $addGrocery, roommate: $roommate, selectedCategory: $selectedCategory)
//            }
    }
    
}

func removeGrocery(list: inout [Grocery], groceryToRemove: Grocery){
    if let index = list.firstIndex(where: { $0.id == groceryToRemove.id }) {
        list.remove(at: index)
    }
}

struct GroceryView_Preview: PreviewProvider {
    static var previews: some View {
        GroceryView()
    }
}

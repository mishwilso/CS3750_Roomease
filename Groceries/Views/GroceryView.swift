//
//  GroceryView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/19/23.
//


import SwiftUI
import FirebaseAuth

struct GroceryView: View {
    @StateObject var groceryManager = GroceryManager()
    @State var purchasedGroceries: [Grocery] = []
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 20){
                //plus button takes you to addgrocery view
                HStack{
                    NavigationLink(destination: AddGroceryView(newGrocery: "", roommate: "", selectedCategory: .none), label: {
                        ZStack{
                            lightGray.frame(width: 60, height: 30).cornerRadius(10)
                            Image(systemName: "plus").foregroundColor(.blue)
                        }
                    })
                }
                List{
                    Section(header: Text("Groceries to purchase")) {
                        if !groceryManager.fruits.isEmpty {
                            ForEach(groceryManager.fruits, id: \.id) { grocery in
                                HStack{
                                    Image("fruits").resizable().frame(width:20, height:20)
                                    Text("\(grocery.name)")
                                    Text("(\(grocery.roommate))")
                                }.swipeActions(edge: .trailing, allowsFullSwipe: true){ Button("Remove") {
                                    purchasedGroceries.append(grocery)
                                    Task{
                                        await delete(grocery: grocery)
                                    }
                                } }.tint(.red)
                            }
                        }
                        
                        if !groceryManager.vegetables.isEmpty {
                            ForEach(groceryManager.vegetables, id: \.id) { grocery in
                                HStack{
                                    Image("vegetables").resizable().frame(width:30, height:30)
                                    Text("\(grocery.name)")
                                    Text("(\(grocery.roommate))")
                                }.swipeActions(edge: .trailing, allowsFullSwipe: true){ Button("Remove") {
                                    purchasedGroceries.append(grocery)
                                    Task{
                                        await delete(grocery: grocery)
                                    }
                                } }.tint(.red)
                            }
                            
                        }
                        if !groceryManager.dairy.isEmpty {
                            ForEach(groceryManager.dairy, id: \.id) { grocery in
                                HStack{
                                    Image("dairy").resizable().frame(width:20, height:30)
                                    Text("\(grocery.name)")
                                    Text("(\(grocery.roommate))")
                                }.swipeActions(edge: .trailing, allowsFullSwipe: true){ Button("Remove") {
                                    purchasedGroceries.append(grocery)
                                    Task{
                                        await delete(grocery: grocery)
                                    }
                                } }.tint(.red)
                            }
                        }
                        if !groceryManager.grains.isEmpty {
                            ForEach(groceryManager.grains, id: \.id) { grocery in
                                HStack{
                                    Image("grains").resizable().frame(width:30, height:30)
                                    Text("\(grocery.name)")
                                    Text("(\(grocery.roommate))")
                                }.swipeActions(edge: .trailing, allowsFullSwipe: true){ Button("Remove") {
                                    purchasedGroceries.append(grocery)
                                    Task{
                                        await delete(grocery: grocery)
                                    }
                                } }.tint(.red)
                            }
                        }
                        if !groceryManager.protein.isEmpty {
                            ForEach(groceryManager.protein, id: \.id) { grocery in
                                HStack{
                                    Image("protein").resizable().frame(width:30, height:30)
                                    Text("\(grocery.name)")
                                    Text("(\(grocery.roommate))")
                                }.swipeActions(edge: .trailing, allowsFullSwipe: true){ Button("Remove") {
                                    purchasedGroceries.append(grocery)
                                    Task{
                                        await delete(grocery: grocery)
                                    }
                                } }.tint(.red)
                            }
                        }
                        if !groceryManager.dessert.isEmpty {
                            ForEach(groceryManager.dessert, id: \.id) { grocery in
                                HStack{
                                    Image("dessert").resizable().frame(width:30, height:30)
                                    Text("\(grocery.name)")
                                    Text("(\(grocery.roommate))")
                                }.swipeActions(edge: .trailing, allowsFullSwipe: true){ Button("Remove") {
                                    purchasedGroceries.append(grocery)
                                    Task{
                                        await delete(grocery: grocery)
                                    }
                                } }.tint(.red)
                            }
                        }
                    }
                }
                List{
                    Section(header: Text("Groceries already bought")){
                        ForEach(purchasedGroceries, id: \.id){ grocery in
                            HStack{
                                Image("\(grocery.category)").resizable().frame(width:30, height:30)
                                Text("\(grocery.name)").strikethrough(true, color: .black)
                                Text("(\(grocery.roommate))")
                                Spacer()
                                Button(action: {purchasedGroceries.removeAll(where: { $0.id == grocery.id })}) {
                                    Image(systemName: "trash")
                                }.tint(.black)
                            }.swipeActions(edge: .leading, allowsFullSwipe: true) { Button("Add back") {
                                Task{
                                    await add(item:grocery, kind: grocery.category)
                                }
                                purchasedGroceries.removeAll(where: { $0.id == grocery.id })
                            } } .tint(.green)
                        }
                        
                    }
                }
            }
        }
    }
    
    func delete(grocery: Grocery) async{
        await groceryManager.removeGrocery(category: grocery.category, groceryName: grocery.name) { error in
            if let error = error {
                print("Error deleting grocery: \(error.localizedDescription)")
            } else {
                print("Grocery deleted successfully")
            }
        }
    }
    func add(item: Grocery, kind: GroceryCategory) async{
        await groceryManager.addGrocery(category: kind, grocery: item) { error in
            if let error = error {
                print("Error adding event: \(error.localizedDescription)")
            } else {
                print("Event added successfully")
            }
         }
    }
}


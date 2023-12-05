//
//  AddGroceryView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/20/23.
//

import SwiftUI

struct AddGroceryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var buttonTappedCategory: GroceryCategory?
    @State var newGrocery: String
    @State var roommate: String
    @State var selectedCategory: GroceryCategory
    @State private var showAlert = false
    
    var body: some View{
        
        VStack (spacing: 5){
            Text("Add a grocery")
                .font(.title)
                .frame(alignment: .topLeading)
            TextField("Enter grocery name", text: $newGrocery)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(.black)
                .padding()
            TextField("Who is this for? (skip if shared grocery)", text: $roommate)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(.black)
                .padding()
            Text("Choose your food category:")
            HStack{
                Button(action: {selectedCategory = .vegetables
                    buttonTappedCategory = .vegetables
                }){Image("vegetables")
                    .resizable().frame(width:70, height:70)}.padding().overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(buttonTappedCategory == .vegetables ? Color.gray : Color.clear, lineWidth: 1)
                    )
                    .cornerRadius(10)
                Button(action: {selectedCategory = .fruits
                    buttonTappedCategory = .fruits
                }){Image("fruits")
                    .resizable().frame(width:50, height:50)}.padding().overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(buttonTappedCategory == .fruits ? Color.gray : Color.clear, lineWidth: 1)
                    )
                    .cornerRadius(10)
                Button(action: {selectedCategory = .dairy
                    buttonTappedCategory = .dairy
                }){Image("dairy")
                    .resizable().frame(width:50, height:50)}.padding().overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(buttonTappedCategory == .dairy ? Color.gray : Color.clear, lineWidth: 1)
                    )
                    .cornerRadius(10)
                
            }.padding()
            HStack{
                Button(action: {selectedCategory = .grains
                    buttonTappedCategory = .grains
                }){Image("grains")
                    .resizable().frame(width:70, height:70)}.padding().overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(buttonTappedCategory == .grains ? Color.gray : Color.clear, lineWidth: 1)
                    )
                    .cornerRadius(10)
                Button(action: {selectedCategory = .protein
                    buttonTappedCategory = .protein
                }){Image("protein")
                    .resizable().frame(width:70, height:70)}.padding().overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(buttonTappedCategory == .protein ? Color.gray : Color.clear, lineWidth: 1)
                    )
                    .cornerRadius(10)
                Button(action: {selectedCategory = .dessert
                    buttonTappedCategory = .dessert
                }){Image("dessert")
                    .resizable().frame(width:70, height:70)}.padding().overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(buttonTappedCategory == .dessert ? Color.gray : Color.clear, lineWidth: 1)
                    )
                    .cornerRadius(10)
                
            }.padding()
        
            }
      
            Button("Done") {
                Task{
                    if !newGrocery.isEmpty && selectedCategory != .none{
                        if roommate.isEmpty {
                            await sendGrocery(item: Grocery(name: newGrocery, roommate: "All", category: selectedCategory), kind: selectedCategory)
                        } else {
                            await sendGrocery(item: Grocery(name: newGrocery, roommate: roommate, category: selectedCategory), kind: selectedCategory)
                        }
                        //go back to previous page
                        presentationMode.wrappedValue.dismiss()
                    }
                    else{
                        showAlert = true
                    }
                }
            }
            .buttonStyle(.bordered)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Missing Information"),
                      message: Text("Please enter a grocery name and select a category."),
                      dismissButton: .default(Text("OK")))
            }
        }
    func sendGrocery(item: Grocery, kind: GroceryCategory) async{
        let groceryManager = GroceryManager()
        await groceryManager.addGrocery(category: kind, grocery: item) { error in
            if let error = error {
                print("Error adding event: \(error.localizedDescription)")
            } else {
                print("Event added successfully")
            }
         }
    }
}

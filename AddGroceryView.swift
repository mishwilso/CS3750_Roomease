//
//  AddGroceryView.swift
//  Roomease
//
//  Created by Emma O'Brien on 10/20/23.
//

import SwiftUI

struct AddGroceryView: View {
    @Binding var groceries: [Grocery]
    @Binding var newGrocery: String
    @Binding var addGrocery: Bool
    @Binding var roommate: String
    @Binding var selectedCategory: GroceryCategory
    
    var body: some View{
        
        VStack {
            Text("Add a grocery")
                .font(.title)
                .frame(alignment: .topLeading)
            TextField("Enter grocery name", text: $newGrocery)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(.black)
                .padding()
            TextField("Enter grocery owner (skip if shared)", text: $roommate)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .border(.black)
                .padding()
            Text("Choose your food group:")
            HStack{
                //TODO - updated images with custom icons
                Button(action: {selectedCategory = .vegetables}){Image(systemName: "carrot")
                    .resizable().frame(width:30, height:30)}.padding()
                Button(action: {selectedCategory = .fruits}){Image(systemName: "fork.knife")
                    .resizable().frame(width:30, height:30)}.padding()
                Button(action: {selectedCategory = .dairy}){Image(systemName: "fork.knife")
                    .resizable().frame(width:30, height:30)}.padding()
                
            }.padding()
            HStack{
                //TODO - update images with custom icons
                Button(action: {selectedCategory = .grains}){Image(systemName: "fork.knife")
                    .resizable().frame(width:30, height:30)}.padding()
                Button(action: {selectedCategory = .protein}){Image(systemName: "fork.knife")
                    .resizable().frame(width:30, height:30)}.padding()
                Button(action: {selectedCategory = .dessert}){Image(systemName: "fork.knife")
                    .resizable().frame(width:30, height:30)}.padding()
                
            }.padding()
            //TODO - remove instructions
            Text("(images are just placeholders, will represent food groups)").font(.caption)
                
            }
      
            Button("Done") {
                if !newGrocery.isEmpty {
                    if roommate == ""{
                        groceries.append(Grocery(name: newGrocery, category: .fruits))
                    } else {
                        groceries.append(Grocery(name: newGrocery, roommate: roommate, category: .fruits))
                    }
                    newGrocery = ""
                    roommate = ""
                    addGrocery = false
                }
            }
            .buttonStyle(.bordered)
        }

        
}

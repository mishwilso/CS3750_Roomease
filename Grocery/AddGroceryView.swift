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
    @Environment(\.presentationMode) var presentationMode
    @State private var buttonTappedCategory: GroceryCategory?
    
    
    var body: some View{
        
        VStack (spacing: 5){
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
            Text("Choose your food category:")
            HStack{
                //TODO - updated images with custom icons
                Button(action: {selectedCategory = .vegetables
                    buttonTappedCategory = .vegetables
                }){Image("vegetable")
                    .resizable().frame(width:70, height:70)}.padding().overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(buttonTappedCategory == .vegetables ? Color.gray : Color.clear, lineWidth: 1)
                    )
                    .cornerRadius(10)
                Button(action: {selectedCategory = .fruits
                    buttonTappedCategory = .fruits
                }){Image("fruit")
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
                //TODO - update images with custom icons
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
                }){Image("meat")
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
                if !newGrocery.isEmpty {
                    if roommate == ""{
                        groceries.append(Grocery(name: newGrocery, category: selectedCategory))
                    } else {
                        groceries.append(Grocery(name: newGrocery, roommate: roommate, category: selectedCategory))
                    }
                    newGrocery = ""
                    roommate = ""
                    addGrocery = false
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .buttonStyle(.bordered)
        }

        
}


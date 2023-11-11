//
//  JoinView.swift
//  Test
//
//  Created by user247737 on 10/18/23.
//

import SwiftUI

struct JoinFormView: View {
    @Binding var houseName : String
    @Binding var houseCode : String
    
    var body: some View {
        ZStack (alignment: .center) {
            //Color.gray
            
            ZStack {
                
                
                Ellipse()
                    .frame(width: 370, height: 320)
                    .padding(.trailing, -500)
                    .foregroundColor(lighterGray)
                    .padding(.top, 300)
                
                Ellipse()
                    .frame(width: 510, height: 478)
                    .padding(.leading, -200)
                    .foregroundColor(lighterGray)
                    .padding(.top, -590)
                
                VStack(spacing: 40){
                    //Join House Box
                    Rectangle()
                        .frame(width: 350, height: 200).cornerRadius(30.0)
                        .foregroundColor(lightGray)
                        .padding(.top, 10)
                    
                    //New House Box
                    Rectangle()
                        .frame(width: 350, height: 200).cornerRadius(30.0)
                        .foregroundColor(lightGray)
                        .padding(.top, 40)
                }.padding(.top, 30)
                
                Rectangle()
                    .frame(width: 458, height: 420)
                    .foregroundColor(lightGray)
                    .padding(.top, 1100)
                
                Text("Welcome to \nRoomease!")
                    .foregroundColor(.white)
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 60).padding(.top, -350)
                
            }
            
            
            ZStack(alignment: .center){
                
                VStack (spacing: 226){
                    Text("").fontWeight(.bold).foregroundColor(.white).frame(height: 58).frame(minWidth: 0, maxWidth: 300).background(lighterGray).cornerRadius(5.0)
                    
                    Text("").fontWeight(.bold).foregroundColor(.white).frame(height: 58).frame(minWidth: 0, maxWidth: 300).background(lighterGray).cornerRadius(5.0)
                }.padding(.horizontal, 25).padding(.top, -40)

                
                VStack (spacing: 240) {
                    CustomTextField(placeHolder: "", bColor: textColor, tOpacity: 0.6, value: $houseCode)
                    
                    CustomTextField(placeHolder: "", bColor: textColor, tOpacity: 0.6, value: $houseName)
                    
                }.padding(.horizontal, 60).padding(.top, -50)
                
                //Insert stuff for "Don't have an account", here
                
                
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        
        
    }
    
}
  

//struct JoinView: View {
//    
//    @State var houseName = ""
//    @State var houseCode = ""
//    @State var errorMessage = "  "
//    @State var errorCode = "  "
//    
//    var body: some View {
//        NavigationView {
//            
//            ZStack (alignment: .center){
//                
//                
//                JoinFormView(houseName: $houseName, houseCode: $houseCode)
//                                
//                //Sign in button
//                VStack(spacing: 95){
//                    if(houseCode.isEmpty){
//                        
//                            Button(action: { errorMessage = "Please Enter Valid House Code"}, label: {
//                                CustomButton(bttnTitle: "Join House", bColor: lighterGray)
//                            })
//                        
//                    } else {
//                        
//                            NavigationLink(destination: NavView(), label: {CustomButton(bttnTitle: "Join House", bColor: lighterGray)})
//                        
//                    }
//                    
//                    Spacer().frame(height: 35)
//                    
//                    if(houseName.isEmpty){
//
//                            Button(action: { errorMessage = "Please Enter Valid House Name"}, label: {
//                                CustomButton(bttnTitle: "Create House", bColor: lighterGray)
//                            })
//                    } else {
//                            NavigationLink(destination: NavView(), label: {CustomButton(bttnTitle: "Create House", bColor: lighterGray)})
//                        
//                    }
//                    
//                    
//                    
//                }.padding(.top, 120)
//                
//                Text(errorMessage).padding(.top, 750).fontWeight(.bold).foregroundColor(.white)
//            }
//            
//        }
//        .navigationBarHidden(true)
//    }
//    
//}
struct JoinView: View {
    
    @State var houseName = ""
    @State var houseCode = ""
    @State var errorMessage = "  "
    @State var errorCode = "  "

    @State private var joinSuccessful = false
    @StateObject var createViewModel = CreateViewModel()
    @StateObject var joinViewModel = JoinViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack (alignment: .center){
                
                JoinFormView(houseName: $createViewModel.houseName, houseCode: $joinViewModel.houseCode)
                
                //Join button
                VStack(spacing: 95){
                    
                    Button(action: {
                        if validateCodeInput(){
                            Task {
                                do {
                                    try await joinViewModel.joinHouse()
                                    joinSuccessful = true
                                } catch {
                                    errorCode = "Join Household Failed"
                                }
                            }
                        } else {
                            errorCode = "Please Enter Valid Credentials"
                        }
                    }) {
                        Text("Join House").fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(height: 58)
                            .frame(minWidth: 0, maxWidth: 300)
                            .background(lighterGray)
                            .cornerRadius(20.0)
                        
                    }
                    
                    Spacer().frame(height: 35)
                    
                    Button(action: {
                        if validateNameInput(){
                            Task {
                                do {
                                    try await createViewModel.registerHouse()
                                    joinSuccessful = true
                                } catch {
                                    errorCode = "Create Household Failed"
                                }
                            }
                        } else {
                            errorCode = "Please Enter Valid Credentials"
                        }
                    }) {
                        Text("Create House").fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(height: 58)
                            .frame(minWidth: 0, maxWidth: 300)
                            .background(lighterGray)
                            .cornerRadius(20.0)
                        
                    }
                    
                    
                }.padding(.top, 120)
                
                Text(errorMessage).padding(.top, 750).fontWeight(.bold).foregroundColor(.white)
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $joinSuccessful) {
            ContentNavView()
        }
    }
                
    func validateNameInput() -> Bool {
        return  !createViewModel.houseName.isEmpty
    }
    func validateCodeInput() -> Bool {
        return  !joinViewModel.houseCode.isEmpty
    }
}


struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView()
    }
}

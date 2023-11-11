//
//  SignInUpView.swift
//  Test
//
//  Created by user247737 on 10/18/23.
//

import SwiftUI

struct SignInUpView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var isLinkActive = false
    var body: some View {
        NavigationStack {
            ZStack (alignment: .center) {
                Text("")
                    .frame(maxWidth:.infinity,maxHeight: .infinity)
                
                ZStack {
                    
                    Rectangle()
                        .frame(width: 308, height: 215).cornerRadius(15.0)
                        .foregroundColor(lightGray)
                        .padding(.top, 500)
                    
                    Ellipse()
                        .frame(width: 510, height: 400)
                        .foregroundColor(white)
                        .padding(.top, -500)
                    
                    
                    
                    Text("Welcome to\nRoommease!")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 110).padding(.top, 150)
                    
                }
                
                //Add Image
                Image(.tempLogo).resizable().frame(width: 200, height: 200).opacity(0.3).padding(.bottom, 470)
                
                VStack(spacing: 80) {
                    
                    VStack(spacing: 30){
                        
                        
                        Spacer().frame(height: 470)
                        
                        NavigationLink(destination: CreateAccountView(),
                                       label: { CustomButton(bttnTitle: "Create Account", bColor: Color.gray)})
                        
                        NavigationLink(destination: LoginView(),
                                       label: { CustomButton(bttnTitle: "Login", bColor: Color.gray)})
                        
                    }
                    
                }
                
                
            }.background(lightGray).ignoresSafeArea(.all)
            
            
            
        }.navigationBarHidden(true)
    }
    
}

struct SignInUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignInUpView()
    }
}

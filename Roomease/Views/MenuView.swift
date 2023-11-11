//
//  MenuView.swift
//  Roomease
//
//  Created by user247737 on 11/9/23.
//

import SwiftUI

struct MenuView: View {
    @State private var profileSet = false
    @State private var settingSet = false
    @State private var signOutSet = false
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                Button(action: {
                    print("Profile Pressed")
                    profileSet = true
                }) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Profile")
                            .foregroundColor(.gray)
                            .font(.headline) //CHANGE IF NECESSARY
                    }
                }.padding(.top, 100)
                Button(action: {
                    print("Settings Pressed")
                    settingSet = true
                }) {
                    HStack {
                        Image(systemName: "gearshape")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Settings")
                            .foregroundColor(.gray)
                            .font(.headline) //CHANGE IF NECESSARY
                    }
                }.padding(.top, 30)
                
                Button(action: {
                    Task {
                        do {
                            print("Log Out Pressed")
                            try await loginViewModel.signOut()
                            signOutSet = true
                        } catch {
                            print("Sign Out Fail :(")
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "multiply")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Log Out")
                            .foregroundColor(.gray)
                            .font(.headline) //CHANGE IF NECESSARY
                    }
                }.padding(.top, 30)
                
                
                Spacer()
            }.padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
        }.navigationBarHidden(true)
            .navigationDestination(isPresented: $profileSet) {ContentNavView()}
            .navigationDestination(isPresented: $settingSet) {ContentNavView()}
            .navigationDestination(isPresented: $signOutSet) {SignInUpView()}
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

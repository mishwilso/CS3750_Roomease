//
//  ContentView.swift
//  Roomease
//
//  Created by Anthony Stem on 10/16/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    var body: some View {
        VStack {
            Text("Roomease Login")
                .font(.largeTitle)
            TextField("Username", text: $loginViewModel.email)
                .padding()
                .cornerRadius(16)
                .background(Color.gray.opacity(0.5))
            SecureField("Password", text: $loginViewModel.password)
                .padding()
                .cornerRadius(16)
                .background(Color.gray.opacity(0.5))
            Button {
                Task { try await loginViewModel.signIn() }
            } label: {
                Text("Log In")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(16)
            }
            Text("Roomease Register")
                .font(.largeTitle)
            TextField("Username", text: $registrationViewModel.email)
                .padding()
                .cornerRadius(16)
                .background(Color.gray.opacity(0.5))
            SecureField("Password", text: $registrationViewModel.password)
                .padding()
                .cornerRadius(16)
                .background(Color.gray.opacity(0.5))
            Button {
                Task { try await registrationViewModel.register() }
            } label: {
                Text("Register")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(16)
            }
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

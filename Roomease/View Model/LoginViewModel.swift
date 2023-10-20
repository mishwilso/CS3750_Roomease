//
//  LoginViewModel.swift
//  Roomease
//
//  Created by Anthony Stem on 10/16/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        print("Attempting log in.")
        try await AuthService.shared.login(email: email, password: password)
    }
}

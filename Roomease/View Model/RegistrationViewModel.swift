//
//  RegistrationViewModel.swift
//  Roomease
//
//  Created by Anthony Stem on 10/16/23.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    
    func register() async throws {
        print("Got to the view model")
        try await AuthService.shared.register(email: email, password: password, firstname: firstname, lastname: lastname)
    }
}

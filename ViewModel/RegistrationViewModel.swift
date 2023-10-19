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
    
    func register() async throws {
        try await AuthService.shared.register(email: email, password: password)
    }
}

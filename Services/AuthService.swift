//
//  AuthService.swift
//  Roomease
//
//  Created by Anthony Stem on 10/16/23.
//

import Foundation
import FirebaseAuth

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) async throws {
        do {
            let loginResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = loginResult.user
            print(self.userSession?.email)
        } catch {
            print("DEBUG: Failed to login user.")
        }
    }
    
    func register(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print(self.userSession?.email)
        } catch {
            print("DEBUG: Failed to register user.")
        }
    }
}

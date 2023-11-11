//
//  LoginViewModel.swift
//  Roomease
//
//

import Foundation

class CreateViewModel: ObservableObject {
    @Published var houseName = ""
    
    func registerHouse() {
        print("Attempting to register house")
        AuthService.shared.createHouse(houseName: houseName)
    }
}

class JoinViewModel: ObservableObject {
    @Published var houseCode = ""
    
    func joinHouse() {
        print("Attempting to login into house")
        AuthService.shared.joinHouse(houseCode: houseCode)
    }
}

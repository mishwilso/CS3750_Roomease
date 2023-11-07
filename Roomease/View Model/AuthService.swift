//
//  AuthService.swift
//  Roomease
//
//  Created by Anthony Stem on 10/16/23.
//
//Resources : https://firebase.google.com/docs/firestore/manage-data/add-data#swift_1
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class AuthService {
    @Published var userSession: FirebaseAuth.User?
        
    static let shared = AuthService();
    
    //static let db = Firestore.firestore();
    
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) async throws {
        do {
            let loginResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = loginResult.user
            print(type(of: userSession))

            print(self.userSession?.email ?? String())
        } catch {
            print("DEBUG: Failed to login user.")
            throw DBError.loginFailed(errorMessage: error.localizedDescription)
        }
    }
    
    func register(email: String, password: String, firstname: String, lastname: String) async throws {
        
        
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                let user = authResult.user
                
                //TODO: Make Firestore class
                let userData: [String: Any] = ["HouseID": 10, "firstName": firstname, "lastName": lastname]
                
                let db = Firestore.firestore()
                
                let userDocument = db.collection("Users").document(user.uid)
                try await userDocument.setData(userData)
                
                print("User registered and data saved successfully")
                
            } catch {
                print("Error registering user or saving user data: \(error.localizedDescription)")
                throw DBError.registrationFailed(errorMessage: error.localizedDescription)
            }
        
    }
    
    func createHouse(houseName: String) {
        // Generate a random ID
        let generatedID = RandomIdGenerator.getBase62(length: 6)
        let db = Firestore.firestore()
        
        // Check if a user is signed in
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            // Update the user's data with the HouseID
            userDocument.setData(["HouseID": generatedID], merge: true) { error in
                if let error = error {
                    print(error)
                    // Handle the error here
                } else {
                    // Data successfully updated -> Now we create the house...hopefully
                    Task.init {
                        do {
                            let houseData: [String: Any] = ["HouseName": houseName]
                            let houseDocument = db.collection("Roomease").document(generatedID)
                            try await houseDocument.setData(houseData)
                            print("House built and saved successfully")
                        } catch {
                            print("Error in creating household")
                            // Handle the error and potentially log or display it
                            throw DBError.registrationFailed(errorMessage: error.localizedDescription)
                        }
                    }
                }
            }
        } else {
            // No user is signed in. Handle this case if needed.
        }
    }
    
    func joinHouse(houseCode: String){
        let db = Firestore.firestore()
        
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            // Update the user's data with the HouseID
            userDocument.setData(["HouseID": houseCode], merge: true) { error in
                if let error = error {
                    print(error)
                    // Handle the error here
                } else {
                    // Data successfully updated
                }
            }
        }
    }
    
    func getHouseCode(completion: @escaping ([String: Any]?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        let collectionReference = db.collection("Users")
        
        // Query the collection (for example, to fetch all documents)
        collectionReference.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion(nil, error)
            } else {
                var fetchedData = [String: Any]()
                for document in querySnapshot!.documents {
                    // Access document data as a dictionary
                    let data = document.data()
                    
                    // You can access specific fields in the document
                    if let houseCode = data["HouseID"] as? String {
                        print("House Code: \(houseCode)")
                    }
                    
                    
                    // Store the data in the result dictionary
                    fetchedData[document.documentID] = data
                }
                
                // Return the data to the completion handler
                completion(fetchedData, nil)
            }
        }
    }



}


        

    
    
    














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
    
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) async throws {
        do {
            let loginResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = loginResult.user
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
                let userData: [String: Any] = ["HouseID": 10, "firstName": firstname, "lastName": lastname, "Chores": [], "Groceries": [], "Events": [], "Messages": []]
                
                let db = Firestore.firestore()
                
                let userDocument = db.collection("Users").document(user.uid)
                try await userDocument.setData(userData)
                
                print("User registered and data saved successfully")
                
            } catch {
                print("Error registering user or saving user data: \(error.localizedDescription)")
                throw DBError.registrationFailed(errorMessage: error.localizedDescription)
            }
        
    }
    
    func addChore(userID: String, task: String, frequency: String, deadline: String) async throws {
        
        do {
            let db = Firestore.firestore()
            let userDocument = db.collection("Users").document(userID)
            
            let documentSnapshot = try await userDocument.getDocument()
            
            if var currentData = documentSnapshot.data() as? [String: Any] {
                
                var chores: [[String: Any]] = currentData["Chores"] as? [[String: Any]] ?? []
                
                let newChore: [String: Any] = ["Task": task, "Frequency": frequency, "Deadline": deadline]
                
                chores.append(newChore)
                
                currentData["Chores"] = chores
                
                try await userDocument.setData(currentData)
                
                print("Chore added")
                
            }
            else {
                print("Chore array not found.")
                
            }
        }
        catch {
            print("Error adding chore: \(error.localizedDescription)")
            throw DBError.choreAddFailed(errorMessage: error.localizedDescription)
        }
        
    }
    
    func addEvent(userID: String, day: Int, endTime: String, month: Int, startTime: Int, title: String, year: Int) async throws {
        do {
            let db = Firestore.firestore()
            let userDocument = db.collection("Users").document(userID)
            
            let documentSnapshot = try await userDocument.getDocument()
            
            if var currentData = documentSnapshot.data as? [String: Any] {
                var events: [[String: Any]] = currentData["Events"] as? [[String: Any]] ?? []
                
                let newEvent: [String: Any] = ["Day": day, "EndTime": endTime, "Month": month, "StartTime": startTime, "Title": title, "Year": year]
                
                events.append(newEvent)
                
                currentData["Events"] = events
                
                try await userDocument.setData(currentData)
                
                print("Event added")
            }
            else {
                print("Event array not found.")
            }
        }
        catch {
            print("Error adding event: \(error.localizedDescription)")
            throw DBErrir.eventAddFailed(errorMessage: error.localizedDescription)
        }
        
    }
    
    func addGrocery(userID: string, item: String, purpose: String, store: String) async throws {
        do {
            let db = Firestore.firestore()
            let userDocument = db.collection("Users").document(userID)
            
            let documentSnapshot = try await userDocument.getDocument()
            
            if var currentData = documentSnapshot.data as? [String: Any] {
                var groceries: [[String: Any]] = currentData["Groceries"] as? [[String: Any]] ?? []
                
                let newGrocery: [String: Any] = ["Item": item, "Purpose": purpose, "Store": store]
                
                groceries.append(newGrocery)
                
                currentData["Groceries"] = groceries
                
                try await userDocument.setData(currentData)
                
                print("Grocery added")
            }
            else {
                print("Grocery array not found.")
            }
        }
        catch {
            print("Error adding grocery: \(error.localizedDescription)")
            throw DBError.groceryAddFailed(errorMessage: error.localizedDescription)
        }
    }
    
    func addMessage(userID: String, messageID: String, message: String, groupID: String, received: Bool, timeStamp: Date, isPinned: Bool) async throws {
        do {
            let db = Firestore.firestore()
            let userDocument = db.collection("Users").document(userID)
            
            let documentSnapshot = try await userDocument.getDocument()
            
            if var currentData = documentSnapshot.data as? [String: Any] {
                var messages: [[String: Any]] = currentData["Messages"] as? [[String: Any]] ?? []
                
                let newMessage: [String: Any] = ["Message": message, "GroupID": groupID, "Received": received, "TimeStamp": timeStamp, "IsPinned": isPinned]
                
                messages.append(newMessage)
                
                currentData["Messages"] = messages
                try await userDocument.setData(currentData)
                
                print("Message added.")
                
            }
            else {
                print("Message array not found.")
            }
        }
        catch {
            print("Error adding message: \(error.localizedDescription)")
            throw DBError.messageAddFailed(errorMessage: error.localizedDescription)
        }
    }
    
    func getChores(userUID: String, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
            let db = Firestore.firestore()
            let userDocument = db.collection("Users").document(userUID)

            userDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting document: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }

                if let documentData = documentSnapshot?.data(),
                   let chores = documentData["Chores"] as? [[String: Any]] {
                    completion(chores, nil)
                } else {
                    // Chores array not found or user document doesn't exist
                    completion(nil, nil)
                }
            }
        }
    
    func getEvents(userID: String, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        let db = Firestore.firestore()
        let userDocument = db.collection("Users").document(userID)
        
        userDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            if let documentData = documentSnapshot?.data(),
               let events = documentData["Events"] as? [[String: Any]] {
                completion(events, nil)
            } else {
                
                completion(nil, nil)
            }
        }
    }
    
    func getGroceries(userID: String, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        let db = Firestore.firestore()
        let userDocument = db.collection("Users").document(userID)
        
        userDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            if let documentData = documentSnapshot?.data(),
               let groceries = documentData["Groceries"] as? [[String: Any]] {
                completion(groceries, nil)
            } else {
                
                completion(nil, nil)
            }
        }
    }
    
    func getMessages(userID: String, completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        let db = Firestore.firestore()
        let userDocument = db.collection("Users").document(userID)
        
        userDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            if let documentData = documentSnapshot?.data(),
               let messages = documentData["Messages"] as? [[String: Any]] {
                completion(messages, nil)
            } else {
                
                completion(nil, nil)
            }
        }
    }
    
    func deleteChore(userUID: String, task: String, completion: @escaping (Error?) -> Void) {
            let db = Firestore.firestore()
            let userDocument = db.collection("Users").document(userUID)

            userDocument.updateData([
                "Chores": FieldValue.arrayRemove([["Task": task]])
            ]) { error in
                if let error = error {
                    print("Error deleting chore: \(error.localizedDescription)")
                    completion(error)
                } else {
                    print("Chore deleted successfully")
                    completion(nil)
                }
            }
        }
    
   
    func deleteGrocery(userUID: String, item: String, completion: @escaping (Error?) -> Void) {
            let db = Firestore.firestore()
            let userDocument = db.collection("Users").document(userUID)

            userDocument.updateData([
                "Groceries": FieldValue.arrayRemove([["Item": task]])
            ]) { error in
                if let error = error {
                    print("Error deleting grocery: \(error.localizedDescription)")
                    completion(error)
                } else {
                    print("Grocery deleted successfully")
                    completion(nil)
                }
            }
        }
    
    func deleteEvent(userUID: String, title: String, completion: @escaping (Error?) -> Void) {
            let db = Firestore.firestore()
            let userDocument = db.collection("Users").document(userUID)

            userDocument.updateData([
                "Events": FieldValue.arrayRemove([["Title": task]])
            ]) { error in
                if let error = error {
                    print("Error deleting event: \(error.localizedDescription)")
                    completion(error)
                } else {
                    print("Event deleted successfully")
                    completion(nil)
                }
            }
        }
    
    func deleteMessage(userUID: String, timeStamp: Date, completion: @escaping (Error?) -> Void) {
            let db = Firestore.firestore()
            let userDocument = db.collection("Users").document(userUID)

            userDocument.updateData([
                "Messages": FieldValue.arrayRemove([["TimeStamp": task]])
            ]) { error in
                if let error = error {
                    print("Error deleting event: \(error.localizedDescription)")
                    completion(error)
                } else {
                    print("Event deleted successfully")
                    completion(nil)
                }
            }
        }
    
}
        

    
    
    














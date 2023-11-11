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
    
    func addChore(task: String, frequency: String, deadline: String) async throws {
        do {
            let db = Firestore.firestore()
            if let user = Auth.auth().currentUser {
                let userDocument = db.collection("Users").document(user.uid)
                let documentSnapshot = try await userDocument.getDocument()
                
                if let currentData = documentSnapshot.data() as? [String: Any], let houseID = currentData["HouseID"] as? Int {
                    // Create a new chore object
                    let newChore: [String: Any] = ["Task": task, "Frequency": frequency, "Deadline": deadline]
                    
                    // Reference the "Roomease" collection and the specific houseID document
                    let roomeaseCollection = db.collection("Roomease")
                    let houseDocument = roomeaseCollection.document("\(houseID)")
                    
                    // Update the "chore" array in the house document
                    houseDocument.updateData([
                        "Chores": FieldValue.arrayUnion([newChore])
                    ]) { error in
                        if let error = error {
                            print("Error adding chore to Roomease: \(error.localizedDescription)")
                            throw DBError.choreAddFailed(errorMessage: error.localizedDescription)
                        } else {
                            print("Chore added to Roomease successfully")
                        }
                    }
                } else {
                    print("HouseID not found in user data or user document not found.")
                }
            }
        } catch {
            print("Error adding chore: \(error.localizedDescription)")
            throw DBError.choreAddFailed(errorMessage: error.localizedDescription)
        }
    }
    
    func addEvent(day: Int, endTime: String, month: Int, startTime: String, title: String, year: Int) async throws {
        do {
            let db = Firestore.firestore()
            if let user = Auth.auth().currentUser {
                let userDocument = db.collection("Users").document(user.uid)
                let documentSnapshot = try await userDocument.getDocument()
                
                if let currentData = documentSnapshot.data() as? [String: Any], let houseID = currentData["HouseID"] as? Int {
                    // Create a new chore object
                    let newEvent: [String: Any] = ["Day": day, "EndTime": endTime, "Month": month, "StartTime": startTime, "Title": title, "Year": year]
                    
                    // Reference the "Roomease" collection and the specific houseID document
                    let roomeaseCollection = db.collection("Roomease")
                    let houseDocument = roomeaseCollection.document("\(houseID)")
                    
                    // Update the "chore" array in the house document
                    houseDocument.updateData([
                        "Events": FieldValue.arrayUnion([newEvent])
                    ]) { error in
                        if let error = error {
                            print("Error adding event to Roomease: \(error.localizedDescription)")
                            throw DBError.choreAddFailed(errorMessage: error.localizedDescription)
                        } else {
                            print("Event added to Roomease successfully")
                        }
                    }
                } else {
                    print("HouseID not found in user data or user document not found.")
                }
            }
        } catch {
            print("Error adding event: \(error.localizedDescription)")
            throw DBError.eventAddFailed(errorMessage: error.localizedDescription)
        }
    }
    
    func addGrocery(item: String, purpose: String, store: String) async throws {
        do {
            let db = Firestore.firestore()
            if let user = Auth.auth().currentUser {
                let userDocument = db.collection("Users").document(user.uid)
                let documentSnapshot = try await userDocument.getDocument()
                
                if let currentData = documentSnapshot.data() as? [String: Any], let houseID = currentData["HouseID"] as? Int {
                    // Create a new chore object
                    let newGrocery: [String: Any] = ["Item": item, "Purpose": purpose, "Store": store]
                    
                    // Reference the "Roomease" collection and the specific houseID document
                    let roomeaseCollection = db.collection("Roomease")
                    let houseDocument = roomeaseCollection.document("\(houseID)")
                    
                    // Update the "chore" array in the house document
                    houseDocument.updateData([
                        "Groceries": FieldValue.arrayUnion([newChore])
                    ]) { error in
                        if let error = error {
                            print("Error adding grocery to Roomease: \(error.localizedDescription)")
                            throw DBError.choreAddFailed(errorMessage: error.localizedDescription)
                        } else {
                            print("Grocery added to Roomease successfully")
                        }
                    }
                } else {
                    print("HouseID not found in user data or user document not found.")
                }
            }
        } catch {
            print("Error adding grocery: \(error.localizedDescription)")
            throw DBError.groceryAddFailed(errorMessage: error.localizedDescription)
        }
    }
    
    func addMessage(messageID: String, message: String, groupID: String, received: Bool, timeStamp: Date, isPinned: Bool) async throws {
        do {
            let db = Firestore.firestore()
            if let user = Auth.auth().currentUser {
                let userDocument = db.collection("Users").document(user.uid)
                let documentSnapshot = try await userDocument.getDocument()
                
                if let currentData = documentSnapshot.data() as? [String: Any], let houseID = currentData["HouseID"] as? Int {
                    // Create a new chore object
                    let newMessage: [String: Any] = ["MessageID": messageID, "Message": message, "GroupID": groupID, "Received": received, "TimeStamp": timeStamp, "IsPinned": isPinned]
                    
                    // Reference the "Roomease" collection and the specific houseID document
                    let roomeaseCollection = db.collection("Roomease")
                    let houseDocument = roomeaseCollection.document("\(houseID)")
                    
                    // Update the "chore" array in the house document
                    houseDocument.updateData([
                        "Messages": FieldValue.arrayUnion([newMessage])
                    ]) { error in
                        if let error = error {
                            print("Error adding message to Roomease: \(error.localizedDescription)")
                            throw DBError.choreAddFailed(errorMessage: error.localizedDescription)
                        } else {
                            print("Message added to Roomease successfully")
                        }
                    }
                } else {
                    print("HouseID not found in user data or user document not found.")
                }
            }
        } catch {
            print("Error adding message: \(error.localizedDescription)")
            throw DBError.choreAddFailed(errorMessage: error.localizedDescription)
        }
    }
    
    func getChores(completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            userDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting user document: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }
                
                guard let documentData = documentSnapshot?.data(),
                      let houseID = documentData["HouseID"] as? Int else {
                    print("HouseID not found in user data or user document not found.")
                    completion(nil, nil)
                    return
                }
                
                // Reference the "Roomease" collection and the specific house document
                let roomeaseCollection = db.collection("Roomease")
                let houseDocument = roomeaseCollection.document("\(houseID)")
                
                houseDocument.getDocument { (houseDocumentSnapshot, houseError) in
                    if let houseError = houseError {
                        print("Error getting house document: \(houseError.localizedDescription)")
                        completion(nil, houseError)
                        return
                    }
                    
                    if let houseDocumentData = houseDocumentSnapshot?.data(),
                       let chores = houseDocumentData["Chores"] as? [[String: Any]] {
                        completion(chores, nil)
                    } else {
                        // Chores array not found or house document doesn't exist
                        completion(nil, nil)
                    }
                }
            }
        }
    }
    
    func getEvents(completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            userDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting user document: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }
                
                guard let documentData = documentSnapshot?.data(),
                      let houseID = documentData["HouseID"] as? Int else {
                    print("HouseID not found in user data or user document not found.")
                    completion(nil, nil)
                    return
                }
                
                // Reference the "Roomease" collection and the specific house document
                let roomeaseCollection = db.collection("Roomease")
                let houseDocument = roomeaseCollection.document("\(houseID)")
                
                houseDocument.getDocument { (houseDocumentSnapshot, houseError) in
                    if let houseError = houseError {
                        print("Error getting house document: \(houseError.localizedDescription)")
                        completion(nil, houseError)
                        return
                    }
                    
                    if let houseDocumentData = houseDocumentSnapshot?.data(),
                       let events = houseDocumentData["Events"] as? [[String: Any]] {
                        completion(events, nil)
                    } else {
                        // Chores array not found or house document doesn't exist
                        completion(nil, nil)
                    }
                }
            }
        }
    }
    
    func getGroceries(completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            userDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting user document: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }
                
                guard let documentData = documentSnapshot?.data(),
                      let houseID = documentData["HouseID"] as? Int else {
                    print("HouseID not found in user data or user document not found.")
                    completion(nil, nil)
                    return
                }
                
                // Reference the "Roomease" collection and the specific house document
                let roomeaseCollection = db.collection("Roomease")
                let houseDocument = roomeaseCollection.document("\(houseID)")
                
                houseDocument.getDocument { (houseDocumentSnapshot, houseError) in
                    if let houseError = houseError {
                        print("Error getting house document: \(houseError.localizedDescription)")
                        completion(nil, houseError)
                        return
                    }
                    
                    if let houseDocumentData = houseDocumentSnapshot?.data(),
                       let groceries = houseDocumentData["Groceries"] as? [[String: Any]] {
                        completion(groceries, nil)
                    } else {
                        // Chores array not found or house document doesn't exist
                        completion(nil, nil)
                    }
                }
            }
        }
    }
    
    func getMessages(completion: @escaping ([[String: Any]]?, Error?) -> Void) {
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            userDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting user document: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }
                
                guard let documentData = documentSnapshot?.data(),
                      let houseID = documentData["HouseID"] as? Int else {
                    print("HouseID not found in user data or user document not found.")
                    completion(nil, nil)
                    return
                }
                
                // Reference the "Roomease" collection and the specific house document
                let roomeaseCollection = db.collection("Roomease")
                let houseDocument = roomeaseCollection.document("\(houseID)")
                
                houseDocument.getDocument { (houseDocumentSnapshot, houseError) in
                    if let houseError = houseError {
                        print("Error getting house document: \(houseError.localizedDescription)")
                        completion(nil, houseError)
                        return
                    }
                    
                    if let houseDocumentData = houseDocumentSnapshot?.data(),
                       let messages = houseDocumentData["Messages"] as? [[String: Any]] {
                        completion(messages, nil)
                    } else {
                        // Chores array not found or house document doesn't exist
                        completion(nil, nil)
                    }
                }
            }
        }
    }

    func deleteChore(task: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            userDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting user document: \(error.localizedDescription)")
                    completion(error)
                    return
                }
                
                guard let documentData = documentSnapshot?.data(),
                      let houseID = documentData["HouseID"] as? Int else {
                    print("HouseID not found in user data or user document not found.")
                    completion(nil)
                    return
                }
                
                // Reference the "Roomease" collection and the specific house document
                let roomeaseCollection = db.collection("Roomease")
                let houseDocument = roomeaseCollection.document("\(houseID)")
                
                houseDocument.updateData([
                    "Chores": FieldValue.arrayRemove([["Task": task]])
                ]) { error in
                    if let error = error {
                        print("Error deleting chore from Roomease: \(error.localizedDescription)")
                        completion(error)
                    } else {
                        print("Chore deleted from Roomease successfully")
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func deleteEvent(title: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            userDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting user document: \(error.localizedDescription)")
                    completion(error)
                    return
                }
                
                guard let documentData = documentSnapshot?.data(),
                      let houseID = documentData["HouseID"] as? Int else {
                    print("HouseID not found in user data or user document not found.")
                    completion(nil)
                    return
                }
                
                // Reference the "Roomease" collection and the specific house document
                let roomeaseCollection = db.collection("Roomease")
                let houseDocument = roomeaseCollection.document("\(houseID)")
                
                houseDocument.updateData([
                    "Events": FieldValue.arrayRemove([["Title": title]])
                ]) { error in
                    if let error = error {
                        print("Error deleting event from Roomease: \(error.localizedDescription)")
                        completion(error)
                    } else {
                        print("Event deleted from Roomease successfully")
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func deleteGrocery(item: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            userDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting user document: \(error.localizedDescription)")
                    completion(error)
                    return
                }
                
                guard let documentData = documentSnapshot?.data(),
                      let houseID = documentData["HouseID"] as? Int else {
                    print("HouseID not found in user data or user document not found.")
                    completion(nil)
                    return
                }
                
                // Reference the "Roomease" collection and the specific house document
                let roomeaseCollection = db.collection("Roomease")
                let houseDocument = roomeaseCollection.document("\(houseID)")
                
                houseDocument.updateData([
                    "Groceries": FieldValue.arrayRemove([["Item": item]])
                ]) { error in
                    if let error = error {
                        print("Error deleting grocery from Roomease: \(error.localizedDescription)")
                        completion(error)
                    } else {
                        print("Grocery deleted from Roomease successfully")
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func deleteMessage(timeStamp: Date, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            userDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting user document: \(error.localizedDescription)")
                    completion(error)
                    return
                }
                
                guard let documentData = documentSnapshot?.data(),
                      let houseID = documentData["HouseID"] as? Int else {
                    print("HouseID not found in user data or user document not found.")
                    completion(nil)
                    return
                }
                
                // Reference the "Roomease" collection and the specific house document
                let roomeaseCollection = db.collection("Roomease")
                let houseDocument = roomeaseCollection.document("\(houseID)")
                
                houseDocument.updateData([
                    "Messages": FieldValue.arrayRemove([["TimeStamp": timeStamp]])
                ]) { error in
                    if let error = error {
                        print("Error deleting message from Roomease: \(error.localizedDescription)")
                        completion(error)
                    } else {
                        print("Message deleted from Roomease successfully")
                        completion(nil)
                    }
                }
            }
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
            userDocument.setData(["HouseID": houseCode], ["Chores": []], ["Groceries": []], ["Events": []], ["Messages": []], merge: true) { error in
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


        

    
    
    














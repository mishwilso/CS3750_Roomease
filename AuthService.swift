//
//  AuthService.swift
//  Roomease
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
    
    func sendMessage(group_id: String, sender: String, text: String, received: Bool, pinned: Bool) async {
        let db = Firestore.firestore()
        var s = ""
        var houseID = ""
        if let user = Auth.auth().currentUser {
            do {
                let userDocument = try await db.collection("Users").document(user.uid).getDocument()
                //let doc = try await userDocument.getDocument()
                let docData = userDocument.data()
                s = "\(docData?["firstName"] ?? "") \(docData?["lastName"] ?? "")"
                houseID = "\(docData?["HouseID"] ?? "")"
                print(sender)
            } catch {
                print("Failed")
            }
        }
        
        if text == "" {
            return
        }
        
        do {
            let newMessage = MessageModel(id: "\(UUID())", group_id: houseID, sender: s, text: text, received: received, timestamp: Date(), pinned: pinned)
            
            try db.collection("ChatMessages").document().setData(from: newMessage)
        } catch {
            print("Error adding chat message to Firestore database.")
        }
        
    }
    
    func getChatMessages(completion: @escaping ([MessageModel], String) -> Void) async {
            
        let db = Firestore.firestore()
        var groupID = ""
        if let user = Auth.auth().currentUser {
            do {
                let userDocument = try await db.collection("Users").document(user.uid).getDocument()
                let docData = userDocument.data()
                groupID = "\(docData?["HouseID"] ?? "")"
            } catch {
                print("Failed")
            }
        }
        
        let semaphore = DispatchSemaphore(value: 0)

        
            db.collection("ChatMessages").whereField("group_id", isEqualTo: groupID) // Add this filter condition
            .addSnapshotListener { documentSnapshot, error in
                
                defer { semaphore.signal() }
                
                guard let documents = documentSnapshot?.documents else {
                    
                    print("Error fetching chat messages.")
                    return
                }
            
            let chatMessages = documents.compactMap { document -> MessageModel? in
                do {
                    return try document.data(as: MessageModel.self)
                } catch {
                    print("Could not decode document into ChatMessage.")
                    return nil
                }
            }
            
            let sortedMessages = chatMessages.sorted {
                $0.timestamp > $1.timestamp
            }
            
            let mostRecentMessageID = sortedMessages.first?.id ?? ""
            print(chatMessages)
            print(sortedMessages)
            print(mostRecentMessageID)
                
            completion(sortedMessages, mostRecentMessageID)
        }
        
   
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
    
    func signOut() async throws{
        do {
            try Auth.auth().signOut()
            print("User Signed Out")
        } catch {
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
        
    
    func createHouse(houseName: String) async {
        // Generate a random ID
        let generatedID = RandomIdGenerator.getBase62(length: 6)
        let db = Firestore.firestore()
        
        // Check if a user is signed in
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            
            // Update the user's data with the HouseID
            userDocument.setData((["HouseID": generatedID]), merge: true) { error in
                if let error = error {
                    print(error)
                    // Handle the error here
                } else {
                    // Data successfully updated -> Now we create the house...hopefully
                    Task.init {
                        do {
                            let houseData: [String: Any] = (["HouseName": houseName])
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
            
            print("Creating House Databases")
            let calendarManager = await CalendarManager()
            await calendarManager.createCalendar(name: houseName, ownerId: user.uid)
            let choreManager = ChoreManager()
            await choreManager.addRoom(roomName: "Kitchen") { error in
                if let error = error {
                    print("Error adding Kitchen: \(error.localizedDescription)")
                } else {
                    print("Kitchen added successfully")
                }
            }
            await choreManager.addRoom(roomName: "Living Room") { error in
                if let error = error {
                    print("Error adding Living Room: \(error.localizedDescription)")
                } else {
                    print("Living Room added successfully")
                }
            }
            await choreManager.addRoom(roomName: "Bathroom") { error in
                if let error = error {
                    print("Error adding Bathroom: \(error.localizedDescription)")
                } else {
                    print("Bathroom added successfully")
                }
            }
            // I ran out of room ideas ;_;
        }
        
    }
    
    func joinHouse(houseCode: String){
        let db = Firestore.firestore()
        
        if let user = Auth.auth().currentUser {
            let userDocument = db.collection("Users").document(user.uid)
            // TODO: Do catch statement to check if houseid exists in collection, throw house not found error if not.
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
    
    func getGroupId() async -> String {
        let db = Firestore.firestore()
        
        var groupID = ""
        if let user = Auth.auth().currentUser {
            do {
                let userDocument = try await db.collection("Users").document(user.uid).getDocument()
                let docData = userDocument.data()
                groupID = "\(docData?["HouseID"] ?? "")"
            } catch {
                print("Failed")
            }
        }
        return groupID
    }
    
    func getIdList(listName: String) async -> [String:String] {
        let db = Firestore.firestore()
    
        //var list: [String: String] = [:]
        guard let user = Auth.auth().currentUser else {
            return [:]
        }
            do {
                let userDocument = try await db.collection("Users").document(user.uid).getDocument()
                let docData = userDocument.data()
                if let list = docData?[listName] as? [String: String] {
                    return list
                } else {
                    return [:] // Return an empty dictionary if the specified field is not a [String: String]
                }
            } catch {
               print("Failed to find list")
               return[:]
            }
    }
    
    func updateIdList(listName: String, newList: [String:String]) async throws {
        let db = Firestore.firestore()
        
        guard let user = Auth.auth().currentUser else {
            throw DBError.registrationFailed(errorMessage: "No user autheticated")

        }
        
        do {
            var existingList = try await getIdList(listName: listName) // Get the existing list
            existingList.merge(newList) { _, new in new } // Merge the existing list with the new list

            // Update the list in the Firestore document
            try await db.collection("Users").document(user.uid).setData([listName: existingList], merge: true)
            } catch {
                throw error
            }
    }

}


        

    
    
    














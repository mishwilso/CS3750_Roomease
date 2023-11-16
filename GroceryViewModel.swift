//
//  GroceryViewModel.swift
//  Roomease
//
//  Created by user247737 on 11/16/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFirestoreSwift

import FirebaseFirestore
import FirebaseFirestoreSwift

enum GroceryCategory: String, CaseIterable, Codable {
    case fruits
    case vegetables
    case dairy
    case grains
    case protein
    case dessert
}

struct Grocery: Codable {
    var name: String
    var roommate: String = "All"
    var completed: Bool
    var category: GroceryCategory
}

class GroceryManager {
    let db = Firestore.firestore()
    var groceryIds: [String: String] = [:]

    init() async {
        // Call an asynchronous method to get the grocery IDs
        await fetchGroceryIds()
    }

    // Define an asynchronous method to fetch grocery IDs
    private func fetchGroceryIds() async {
        let ids = await AuthService.shared.getIdList(listName: "groceryIds")
        groceryIds = ids
    }
    
    func addGrocery(category: GroceryCategory, grocery: Grocery, completion: @escaping (Error?) -> Void) async {
        let groceryListId = await AuthService.shared.getGroupId()
        do {
            let groceryRef = try db.collection("groceryLists").document(groceryListId).collection(category.rawValue).addDocument(from: grocery)
            print("Added grocery with ID: \(groceryRef.documentID)")
            
            // Update the dictionary with the new grocery information
            groceryIds[grocery.name] = groceryRef.documentID
            try await AuthService.shared.updateIdList(listName: "groceryIds", newList: groceryIds)
            
            completion(nil)
        } catch {
            print("Error adding grocery: \(error.localizedDescription)")
            completion(error)
        }
        
    }

    func removeGrocery(category: GroceryCategory, groceryName: String, completion: @escaping (Error?) -> Void) async{
        let groceryListId = await AuthService.shared.getGroupId()
        
        guard let groceryId = groceryIds[groceryName] else {
            print("Grocery not found")
            completion(nil) // Or you can pass an error indicating that the grocery was not found
            return
        }
        db.collection("groceryLists").document(groceryListId).collection(category.rawValue).document(groceryId).delete { error in
            if let error = error {
                print("Error removing grocery: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Grocery successfully removed")
                completion(nil)
            }
        }
        
        do {
            try await AuthService.shared.updateIdList(listName: "groceryIds", newList: groceryIds)
        } catch {
            print("Failed to update ID list")
        }
    }

    func getGroceries(category: GroceryCategory, completion: @escaping ([Grocery]?, Error?) -> Void) async {
        let groceryListId = await AuthService.shared.getGroupId()
        db.collection("groceryLists").document(groceryListId).collection(category.rawValue).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting groceries: \(error.localizedDescription)")
                completion(nil, error)
            } else {
                let groceries = snapshot?.documents.compactMap { document -> Grocery? in
                    try? document.data(as: Grocery.self)
                }
                completion(groceries, nil)
            }
        }
    }
}

///How to Call the Functions:
//
// groceryManager = await groceryManager()
// ## Add an event to the calender
//  Uses the Event Codable :) if there needs to be more things let me know.
//let grocery = Grocery(name: "Bread", roommate: "Mish", completed: false, category: .grains)
// groceryManagaer.addGrocery(category: .grain, grocery: grocery) { error in
//    if let error = error {
//        #You can use this to catch errors, and print something on the screen to say the event wasn't added properly :)
//        print("Error adding event: \(error.localizedDescription)")
//    } else {
//        print("Event added successfully")
//    }
// }

// ## Retrieve groceries
//groceryManager.getGroceries(category: .grain) { groceries, error in
//    if let error = error {
//        print("Error getting events: \(error.localizedDescription)")
//    } else {
//        if let groceries = groceries {
//            print("Groceries for Grain \(groceries):")
//            for grocery in groceries {
//               #You can access the different parts of an event like this-> so it's very modifiable :)
//                print("\(grocery.name)")
//            }
//        } else {
//            print("No groceries found for grain")
//        }
//    }
//}

// Delete an event
//let groceryIdtoDelete = "random unique generated code"
//groceryManager.deleteGrocery(groceryCategory: .grain, groceryName: "Bread") { error in
//    if let error = error {
//        print("Error deleting event: \(error.localizedDescription)")
//    } else {
//        print("Event deleted successfully")
//    }
//}


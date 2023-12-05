//
//  GroceryViewModel.swift
//  Roomease
//
//  Created by user247737 on 11/16/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class GroceryManager: ObservableObject {
    let db = Firestore.firestore()
    var groceryIds: [String: String] = [:]
    @Published private(set) var fruits: [Grocery] = []
    @Published private(set) var vegetables: [Grocery] = []
    @Published private(set) var dairy: [Grocery] = []
    @Published private(set) var grains: [Grocery] = []
    @Published private(set) var protein: [Grocery] = []
    @Published private(set) var dessert: [Grocery] = []

    init(){
        Task.init{
            await getGroceries(category:.fruits)
            await getGroceries(category:.vegetables)
            await getGroceries(category:.dairy)
            await getGroceries(category:.protein)
            await getGroceries(category:.grains)
            await getGroceries(category:.dessert)
            // Call an asynchronous method to get the grocery IDs
            await fetchGroceryIds()
        }
    }

    // Define an asynchronous method to fetch grocery IDs
    private func fetchGroceryIds() async {
        let ids = await AuthService.shared.getIdList(listName: "groceryIds")
        self.groceryIds = ids
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
        await fetchGroceryIds()
        
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
        
        groceryIds.removeValue(forKey: groceryName)
        
        do {
            try await AuthService.shared.updateIdList(listName: "groceryIds", newList: groceryIds)
        } catch {
            print("Failed to update ID list")
        }
    }

    func getGroceries(category: GroceryCategory) async {
        let groceryListId = await AuthService.shared.getGroupId()
        db.collection("groceryLists").document(groceryListId).collection(category.rawValue)
            .addSnapshotListener { documentSnapshot, error in
                guard let documents = documentSnapshot?.documents else{
                    print("Error fetching rooms")
                    return
                }
                switch category {
                case .fruits:
                    self.fruits = documents.compactMap{ document -> Grocery? in
                        do{
                            return try document.data(as: Grocery.self)
                        } catch {
                            print("Cannot decode into room")
                            return nil
                        }
                    }
                case .vegetables:
                    self.vegetables = documents.compactMap{ document -> Grocery? in
                        do{
                            return try document.data(as: Grocery.self)
                        } catch {
                            print("Cannot decode into room")
                            return nil
                        }
                    }
                case .protein:
                    self.protein = documents.compactMap{ document -> Grocery? in
                        do{
                            return try document.data(as: Grocery.self)
                        } catch {
                            print("Cannot decode into room")
                            return nil
                        }
                    }
                case .dairy:
                    self.dairy = documents.compactMap{ document -> Grocery? in
                        do{
                            return try document.data(as: Grocery.self)
                        } catch {
                            print("Cannot decode into room")
                            return nil
                        }
                    }
                case .grains:
                    self.grains = documents.compactMap{ document -> Grocery? in
                        do{
                            return try document.data(as: Grocery.self)
                        } catch {
                            print("Cannot decode into room")
                            return nil
                        }
                    }
                case .dessert:
                    self.dessert = documents.compactMap{ document -> Grocery? in
                        do{
                            return try document.data(as: Grocery.self)
                        } catch {
                            print("Cannot decode into room")
                            return nil
                        }
                    }
                case .none:
                    print("Something went wrong - this shouldn't be happening")
                }
            }
                
    }

}

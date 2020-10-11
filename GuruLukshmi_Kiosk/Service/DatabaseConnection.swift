//
//  DatabaseConnection.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseConnection: ObservableObject {
    @Published var arrayOfCategory = [FoodCategory]()
    @Published var arrayOfFoodList = [Food]()
    @Published var accessCode = [AccessCode]()
 
    let db = Firestore.firestore()
    
    init() {
        loadFood()
        loadCategory()
    }
    
    func loadCategory() {
        db.collection("FoodCategory")
            .order(by: "foodType")
        //.order(by: "orderedTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.arrayOfCategory = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: FoodCategory.self)
                        return x
                    }
                    catch{
                        print(error)
                    }
                    return nil
                    
                }
            }
        }
    }
    
    func loadFood() {
        db.collection("Food")
        //.order(by: "orderedTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.arrayOfFoodList = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: Food.self)
                        return x
                    }
                    catch{
                        print(error)
                    }
                    return nil
                    
                }
            }
        }
    }
    
    func loadAccessCode() {
        db.collection("AccessCode")
            //.order(by: "foodType")
        //.order(by: "orderedTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.accessCode = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: AccessCode.self)
                        return x
                    }
                    catch{
                        print(error)
                    }
                    return nil
                    
                }
            }
        }
    }
    
    func addOrders(_ order: Orders){
        do{
            let _ = try db.collection("Orders").addDocument(from: order)
           
        }
        catch{
            fatalError("Enable to add Order: \(error.localizedDescription)")
        }
        
    }
    
    func addFoodCategory(_ foodCategory: FoodCategory){
        do{
           
            let _ = try db.collection("FoodCategory").addDocument(from: foodCategory)
        }
        catch{
            fatalError("Enable to add Order: \(error.localizedDescription)")
        }
    }
    
    func addFoods(_ food: Food){
        do{
           
            let _ = try db.collection("Food").addDocument(from: food)
           // db.collection("Food").whereField("categoryID", isEqualTo: food.foodType.id)
        }
        catch{
            fatalError("Enable to add Order: \(error.localizedDescription)")
        }
    }
}

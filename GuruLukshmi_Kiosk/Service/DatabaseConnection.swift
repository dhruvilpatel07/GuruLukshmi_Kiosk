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
 
    let db = Firestore.firestore()
    
    
    func addOrders(_ order: Orders){
        do{
           
            let _ = try db.collection("Orders").addDocument(from: order)
        }
        catch{
            fatalError("Enable to add Order: \(error.localizedDescription)")
        }
        
    }
}

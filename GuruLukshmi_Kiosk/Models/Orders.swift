//
//  Order.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

//This will be the main Order strcuture which will be addded to database
struct Orders: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var cName: String = "Dhruvil Patel"
    var listOfOrder = [ListOfOrder]()
    @ServerTimestamp var orderedTime: Timestamp?
    
}

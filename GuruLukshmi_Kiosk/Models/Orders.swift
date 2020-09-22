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

struct Orders: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var cName: String = "Dhruvil Patel"
    var foodName: String
    var foodQuantity: Int
    var foodRefrence: Food?
    @ServerTimestamp var orderedTime: Timestamp?
    
}

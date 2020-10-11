//
//  Users.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-10-10.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Users: Codable, Identifiable, Hashable{
    
    @DocumentID var id: String?
    var user: String
    var password: String
    var isDineIn: Bool
}

//
//  ListOfOrder.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-23.
//

import Foundation
import Combine

//Individual order which is placed inside the cart/my order
struct ListOfOrder: Codable, Identifiable, Hashable{
    
    var id = UUID().uuidString
    var foodRefrence: Food
    var foodQuantity: Int
    var specialInstruction: String?
}

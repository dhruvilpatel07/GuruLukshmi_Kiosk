//
//  GlobalVariables.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import Foundation

class GlobalVariables: ObservableObject {
    @Published var food = testData[0]
    @Published var foodInCart = [ListOfOrder]()
    @Published var subTotal = 0.0
}

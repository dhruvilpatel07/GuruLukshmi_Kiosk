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
    @Published var finalTotal = 0.0
    @Published var tax = 0.0
    @Published var didPaymentWentThrough = false
    @Published var dummyOrderForPayment = Orders(isDineIn: false)
    @Published var progressBarStatus = 0.25
    
    
}

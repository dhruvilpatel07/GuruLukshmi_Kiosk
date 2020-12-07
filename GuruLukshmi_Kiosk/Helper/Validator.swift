//
//  Validator.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-11-23.
//

import Foundation

/// Class which has all the validation
class Validator: ObservableObject {
    
    /// It validates the email which was provided by customer
    /// - Parameter email: Email which was provided by customer to validation
    /// - Returns: Return true if the email is valid
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

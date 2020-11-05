//
//  PaymentGateway.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-11-04.
//

import Foundation
import Braintree
import SwiftUI

class PaymentGateway: UIViewController, ObservableObject, BTViewControllerPresentingDelegate, BTAppSwitchDelegate {
    
    var braintreeClient: BTAPIClient?
    //@Published var didPaymentWentThrough = false
    
    
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        braintreeClient = BTAPIClient(authorization: "sandbox_s9krb2v4_czfsybc4wywt2b2t")!
        super.init(nibName: nil, bundle: nil)
    }
    
    func PayNow(amount: Double) {
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self // Optional
        
        // Specify the transaction amount here.
        let request = BTPayPalRequest(amount: String(format: "%.2f", amount))
        request.currencyCode = "CAD" // Optional; see BTPayPalRequest.h for more options
        request.displayName = "Guru Lakshmi"
        
        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                // Access additional information
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone
                print("Email: \(String(describing: email))\nFirst Name: \(String(describing: firstName))\nLast Name: \(String(describing: lastName))\nPhone: \(String(describing: phone))")
                //self.didPaymentWentThrough = true
                //print(self.didPaymentWentThrough)
                
                print(request.amount)
            } else if let error = error {
                // Handle error here...
                print(error.localizedDescription)
            } else {
                // Buyer canceled payment approval
            }
        }
    }
    
    
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
            
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
}

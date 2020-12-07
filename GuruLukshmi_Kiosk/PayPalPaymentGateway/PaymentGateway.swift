//
//  PaymentGateway.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-11-04.
//

import Foundation
import Braintree
import SwiftUI


/** #PayPal Payment Gateway
    - Taking amount from subTotal and charging it to customer through paypal */
final class PaymentGateway: UIViewController, ObservableObject, BTViewControllerPresentingDelegate, BTAppSwitchDelegate {
    
    var braintreeClient: BTAPIClient?
    
    
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        braintreeClient = BTAPIClient(authorization: "sandbox_s9krb2v4_czfsybc4wywt2b2t")!
        super.init(nibName: nil, bundle: nil)
    }
    
    /// PayNow fucntion which will create charges and send through PayPal
    /// - Parameters:
    ///   - amount: the amount which needs to be charged
    ///   - finished: compelition handler which will make sure that customers have been charged before adding order to database
    public func PayNow(amount: Double, finished:@escaping (Bool) -> ()) {
        
        DispatchQueue.main.async {
            let payPalDriver = BTPayPalDriver(apiClient: self.braintreeClient!)
            payPalDriver.viewControllerPresentingDelegate = self
            payPalDriver.appSwitchDelegate = self 
            
            // Specify the transaction amount here.
            let request = BTPayPalRequest(amount: String(format: "%.2f", amount))
            request.currencyCode = "CAD"
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
                    print(request.amount)
                    print(tokenizedPayPalAccount.creditFinancing)
                    
                    finished(true)
                } else if let error = error {
                    // Handle error here...
                    print(error.localizedDescription)
                } else {
                    // Buyer canceled payment approval
                }
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

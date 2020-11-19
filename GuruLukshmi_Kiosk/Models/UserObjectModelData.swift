//
//  UserObjectModelData.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-10-10.
//

import Foundation
import SwiftUI
import Firebase
import LocalAuthentication

class UserObjectModelData : ObservableObject {
    
    @Published var userId = ""
    @Published var password = ""
    @ObservedObject var db = DatabaseConnection()
    var userFound = false
    @Published var correctLogoutPassword = false
    
    // Error Alerts
    @Published var alert = false
    @Published var alertMsg = ""
    
    // User Status
    @AppStorage("log_Status") var status = false
    @AppStorage("log_Dine_In") var isDineIn = false
    @AppStorage("log_Table_Number") var tableNumber = 0
    
    
    //Logout password check
    func checkLogoutPass(){
        
        let alert = UIAlertController(title: "Enter Password", message: "Enter Your Password to logout", preferredStyle: .alert)
        
        alert.addTextField { (password) in
            password.placeholder = "Password"
            password.isSecureTextEntry = true
            
        }
        
        
        let proceed = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            // Sending Password Link
            
            if alert.textFields![0].text! != ""{
                
                if alert.textFields![0].text! == "1234" {
                    self.correctLogoutPassword = true
                    
                    withAnimation{
                        self.logOut()
                    }
                }else{
                    self.alertMsg = "Incorrect Password"
                    self.alert.toggle()
                    //return
                }
                
           
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // Presenting
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    // Login
    func login(){
        
        // checking all fields are inputted correctly
        
        if userId == "" || password == ""{
            
            self.alertMsg = "Fill the contents properly !!!"
            self.alert.toggle()
            return
        }
        
        for user in self.db.arrayOfKioskLoginId {
            if user.user == userId && user.password == password{
               // isDineIn = user.isDineIn
                if user.isDineIn{ isDineIn = true }
                self.userFound = true
            }
        }
        
        if userFound {
            withAnimation{
                self.status = true
            }
        }else{
            self.alertMsg = "User Id or Password doesn't match our records!"
            self.alert.toggle()
            return
        }

    }
    
    func logOut(){
        withAnimation{
            self.status = false
            self.isDineIn = false
            self.tableNumber = 0
            self.correctLogoutPassword = false
        }
        // clearing all data
        userId = ""
        password = ""
        userFound = false
        isDineIn = false
    }
    
    //Send emial reciept
    func sendEmail(foodList: [ListOfOrder], orderTotalAmount: Double, totalBeforeTaxes: Double, orderID: String, cEmail: String, cName: String){
        
        let format = UIGraphicsPDFRendererFormat()
        let metaData = [
            kCGPDFContextTitle: "Hello, World!",
            kCGPDFContextAuthor: "John Doe"
          ]
        format.documentInfo = metaData as [String: Any]
        let pageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        
        let title = "Guru Lukshmi\n\n"
        let contactInfo = ""
        let address = String(" 7070 St Barbara Blvd #50\n Mississauga ON\n L5W 0E6\n (905) 795-2299")
        let orderSummaryTitle = "Order Summary\n"
        let summaryLegend = "QTY\t\tFOOD NAME\t\t\t\t\t\t\t\t\t\t\t\t\t\tAMOUNT"
        let subTotal = "SUBTOTAL"
        let taxes = "TAXES"
        let totalPrice = "TOTAL"
        let orderId = "ORDER # \(orderID)"
        let date = Date().localizedDescription
        let paymentSummaryTitle = "Payment Summary\n"
        let paymentCustomerName = "CUSTOMER NAME: \t \(cName)"
        let paymentCustomerEmail = "CUSTOMER EMAIL: \t\(cEmail)"
        let paymentTypeSelected = "PAYMENT METHOD: \tPayPal"
       
        //var foodName = "ff"

        let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36), NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        let contactInfoAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        let addressAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        let orderSummaryTitleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        let summaryLegentAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        let orderAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        let orderIdAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)]
       // let foodNameAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        

        let formattedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
        let formattedContactInfo = NSMutableAttributedString(string: contactInfo, attributes: contactInfoAttribute)
        let formattedAddress = NSMutableAttributedString(string: address, attributes: addressAttributes)
        let formattedOrderSummaryTitle = NSMutableAttributedString(string: orderSummaryTitle, attributes: orderSummaryTitleAttributes)
        let formattedSummaryLegend = NSMutableAttributedString(string: summaryLegend, attributes: summaryLegentAttributes)
        let formattedsubtotal = NSMutableAttributedString(string: subTotal, attributes: orderAttributes)
        let formattedtaxes = NSMutableAttributedString(string: taxes, attributes: orderAttributes)
        let formattedTotalPrice = NSMutableAttributedString(string: totalPrice, attributes: orderAttributes)
        let formattedOrderId = NSMutableAttributedString(string: orderId, attributes: orderIdAttributes)
        let formattedDate = NSMutableAttributedString(string: date, attributes: orderIdAttributes)
        let formattedPaymentSummaryTitle = NSMutableAttributedString(string: paymentSummaryTitle, attributes: orderSummaryTitleAttributes)
        let formattedCustomerName = NSMutableAttributedString(string: paymentCustomerName, attributes: orderAttributes)
        let formattedCustomerEmail = NSMutableAttributedString(string: paymentCustomerEmail, attributes: orderAttributes)
        let formattedPaymentType = NSMutableAttributedString(string: paymentTypeSelected, attributes: orderAttributes)
        
        
        //let formattedFoodName = NSMutableAttributedString(string: foodName, attributes: foodNameAttributes)
        formattedContactInfo.append(formattedAddress)
        //formattedTitle.append(formattedAddress)
        
        
        let data = renderer.pdfData { (ctx) in
            ctx.beginPage()
            let taxesAmount = (totalBeforeTaxes * 0.13)
            let formattedSubTotalAmount = NSMutableAttributedString(string: String(format: "$ %.2f", totalBeforeTaxes), attributes: orderAttributes)
            let formattedTaxesAmount = NSMutableAttributedString(string: String(format: "$ %.2f", taxesAmount), attributes: orderAttributes)
            let formattedTotalPriceAmount = NSMutableAttributedString(string: String(format: "$ %.2f", orderTotalAmount), attributes: orderAttributes)
           

            formattedTitle.draw(in: pageRect.insetBy(dx: 180, dy: 50))
            formattedOrderId.draw(at: CGPoint(x: 405, y: 120))
            formattedDate.draw(at: CGPoint(x: 405, y: 140))
            formattedContactInfo.draw(in: pageRect.insetBy(dx: 50, dy: 120))
            formattedOrderSummaryTitle.draw(in: pageRect.insetBy(dx: 210, dy: 210))
            formattedSummaryLegend.draw(in: pageRect.insetBy(dx: 50, dy: 250))
            //var x = 210
            var y = 290
            
            //Displaying Qty / name/ price
            for food in foodList{
                let foodName = food.foodRefrence.foodName
                let foodQty = food.foodQuantity
                let foodPrice = food.foodRefrence.foodPrice * Double(foodQty)
                let formattedFoodName = NSMutableAttributedString(string: foodName, attributes: orderAttributes)
                let formattedFoodQty = NSMutableAttributedString(string: String(foodQty), attributes: orderAttributes)
                let formattedFoodPrice = NSMutableAttributedString(string: String(format: "$ %.2f", foodPrice), attributes: orderAttributes)
                formattedFoodQty.draw(in: pageRect.insetBy(dx: 60, dy: CGFloat(y)))
                formattedFoodName.draw(in: pageRect.insetBy(dx: 140, dy: CGFloat(y)))
                
                formattedFoodPrice.draw(at: CGPoint(x: 405, y: y))
                
                y += 20
            }
            
            y += 30
            formattedsubtotal.draw(at: CGPoint(x: 340, y: y))
            formattedSubTotalAmount.draw(at: CGPoint(x: 405, y: y))
            
            y += 20
            formattedtaxes.draw(at: CGPoint(x: 340, y: y))
            formattedTaxesAmount.draw(at: CGPoint(x: 405, y: y))
            
            y += 20
            formattedTotalPrice.draw(at: CGPoint(x: 340, y: y))
            formattedTotalPriceAmount.draw(at: CGPoint(x: 405, y: y))
            
            y += 40
            formattedPaymentSummaryTitle.draw(at: CGPoint(x: 210, y: y))
            
            y += 40
            formattedCustomerName.draw(at: CGPoint(x: 100, y: y))
            formattedCustomerEmail.draw(at: CGPoint(x: 270, y: y))
            
            y += 20
            formattedPaymentType.draw(at: CGPoint(x: 100, y: y))
            
            
        }
        print("LIST ---- \(foodList)")
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "dhruvilp263@gmail.com"
        smtpSession.password = "ksrcicfmckrpdwwc"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: cName, mailbox: cEmail)!]
        builder.header.from = MCOAddress(displayName: "Guru Lukshmi", mailbox: "dhruvilp263@gmail.com")
        builder.header.subject = "Payment receipt from Guru Lakshmi"
        builder.htmlBody="<p>Thank you for your order.<br>Please see attachments for your Receipt.</p>"
        builder.addAttachment(MCOAttachment(data: data, filename: "Receipt.pdf"))
       
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
                
                
            } else {
                NSLog("Successfully sent email!")
                
                
            }
        }
    }

    
    
    
}

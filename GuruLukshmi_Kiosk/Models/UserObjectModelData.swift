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
    func sendEmail(){
        
        let format = UIGraphicsPDFRendererFormat()
        let metaData = [
            kCGPDFContextTitle: "Hello, World!",
            kCGPDFContextAuthor: "John Doe"
          ]
        format.documentInfo = metaData as [String: Any]
        let pageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        
        let title = "School report\n"
        let text = String(repeating: "This is an important report about the weather. ", count: 20)

        let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]
        let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]

        let formattedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
        let formattedText = NSAttributedString(string: text, attributes: textAttributes)
        formattedTitle.append(formattedText)
        
        
        let data = renderer.pdfData { (ctx) in
            ctx.beginPage()

            formattedTitle.draw(in: pageRect.insetBy(dx: 50, dy: 50))
        }
        
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
        builder.header.to = [MCOAddress(displayName: "Charles", mailbox: "dhruvilpatel07@icloud.com")!]
        builder.header.from = MCOAddress(displayName: "Xavier", mailbox: "dhruvilp263@gmail.com")
        builder.header.subject = "Test Email"
        builder.htmlBody="<p>Thank you for watching</p>"
        builder.addAttachment(MCOAttachment(data: data, filename: "Bill.pdf"))
       
        
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

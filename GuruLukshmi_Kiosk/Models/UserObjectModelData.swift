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
    
}

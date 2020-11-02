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
    @Published var isDineIn = false
    
    // Error Alerts
    @Published var alert = false
    @Published var alertMsg = ""
    
    // User Status
    @AppStorage("log_Status") var status = false
    
    
    
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
                isDineIn = user.isDineIn
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
        }
        // clearing all data
        userId = ""
        password = ""
        userFound = false
        isDineIn = false
    }
    
}

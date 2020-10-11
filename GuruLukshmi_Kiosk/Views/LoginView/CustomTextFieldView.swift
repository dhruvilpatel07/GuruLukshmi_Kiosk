//
//  CustomTextFieldView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-10-10.
//

import SwiftUI

struct CustomTextFieldView: View {
    var image : String
    var placeHolder : String
    @Binding var txt : String
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(.newSecondaryColor)
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(Circle())
            
            ZStack{
                
                if placeHolder == "Password" || placeHolder == "Re-Enter"{
                    SecureField(placeHolder, text: $txt)
                }
                else{
                    TextField(placeHolder, text: $txt)
                }
            }
                .padding(.horizontal)
                .padding(.leading,65)
                .foregroundColor(.white)
                .frame(height: 60)
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView(image: "mail", placeHolder: "User", txt: .constant("hey"))
    }
}

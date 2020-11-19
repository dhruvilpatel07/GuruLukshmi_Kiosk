//
//  CustomTextFieldForPayment.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-11-10.
//

import SwiftUI

struct CustomTextFieldForPayment: View {
    var image : String
    var placeHolder : String
    @Binding var txt : String
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            Image(systemName: image)
                //.font(.system(size: 30))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.black)
                .clipShape(Circle())
            
            ZStack{
                TextField(placeHolder, text: $txt)
            }
                .padding(.horizontal)
                .padding(.leading,35)
                .foregroundColor(.black)
                .frame(height: 50)
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

struct CustomTextFieldForPayment_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldForPayment(image: "mail", placeHolder: "User", txt: .constant("hey"))
    }
}

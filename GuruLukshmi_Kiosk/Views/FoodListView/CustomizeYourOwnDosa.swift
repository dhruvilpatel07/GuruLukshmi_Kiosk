//
//  CustomizeYourOwnDosa.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-10-03.
//

import SwiftUI

struct CustomizeYourOwnDosa: View {
    let fade =  Gradient(colors: [Color.black, Color.clear])
    var body: some View {
        ZStack{
            Color.newSecondaryColor.edgesIgnoringSafeArea(.all)
            VStack {
                HStack{
                    Image("Dosa")
                        .resizable()
                        .frame(width: 500, height: 500)
                        .cornerRadius(20)
                    //Spacer()
                    VStack(alignment: .leading){
                        Text("Size:")
                            .font(.system(size: 25, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .foregroundColor(.newPrimaryColor)
                        Text("Paste:")
                            .font(.system(size: 25, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .foregroundColor(.newPrimaryColor)
                        Text("Masala:")
                            .font(.system(size: 25, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .foregroundColor(.newPrimaryColor)
                        Text("Topping:")
                            .font(.system(size: 25, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .foregroundColor(.newPrimaryColor)
                        Text("Spicy Level:")
                            .font(.system(size: 25, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .foregroundColor(.newPrimaryColor)
                        
                        Spacer()
                    }
                    .padding([.top, .leading])
                    .frame(width: 500, height: 500, alignment: .leading)
                    .background(Color.white.opacity(0.1))
                }
                .padding([.top, .horizontal ])
                Spacer()
                
            }
            
        }
    }
}

struct CustomizeYourOwnDosa_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeYourOwnDosa()
    }
}

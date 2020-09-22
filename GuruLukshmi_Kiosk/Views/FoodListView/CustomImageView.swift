//
//  CustomImageView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import SwiftUI

struct CustomImageView: View {
    let fade =  Gradient(colors: [Color.black, Color.clear])
    var food: Food
    var body: some View {
        ZStack{
            Color.newSecondaryColor
            Image(food.categoryImgName).resizable()
                .mask(LinearGradient(gradient: fade, startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
                .frame(width: 240, height: 240)
                .overlay(
                    Text("$8.50").foregroundColor(.white).font(.largeTitle)
                        .padding()
                        .padding()
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.green, lineWidth: 6)
                        )
                        .offset(x: 120, y: -120)
                )
                .overlay(
                    Text(food.foodName).foregroundColor(.white).font(.largeTitle).multilineTextAlignment(.center)
                        .offset(x: 0, y: 70)
                )
        }
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(food: testData[0])
    }
}

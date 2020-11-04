//
//  CustomImageView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import SwiftUI

/// # Custome Image class for styling how food list will display in FoodListByCategory.swift
struct CustomImageView: View {
    let fade =  Gradient(colors: [Color.black, Color.clear])
    var food: Food
    var body: some View {
        ZStack{
            Color.newSecondaryColor
            Image(food.categoryImage).resizable()
                .mask(LinearGradient(gradient: fade, startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
                .frame(width: 240, height: 240)
                .overlay(
                    Circle()
                        .fill(Color.green)
                        .opacity(0.7)
                        .frame(width: 100, height: 100)
                        .overlay(
                            Text("$\(String(format: "%.2f" ,food.foodPrice))").foregroundColor(.white).font(.system(size: 28, weight: Font.Weight.heavy, design: Font.Design.rounded))
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

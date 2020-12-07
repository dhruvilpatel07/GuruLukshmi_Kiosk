//
//  CustomImageView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import SwiftUI

/// # Custome Image class for styling how food list will display in FoodListByCategory.swift
struct CustomImageView: View {
    let fade =  Gradient(colors: [Color.clear, Color.black, Color.clear])
    var food: Food
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            Color.clear
            Image(food.imgName).resizable()
                //.mask(LinearGradient(gradient: fade, startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
                //.shadow(color: colorScheme == .dark ? .white : .black, radius: colorScheme == .dark ? 6 : 8, x: colorScheme == .dark ? 2 : 5, y: 5)
                .shadow(color: .black, radius: 8, x: 5, y: 5)
                .frame(width: 240, height: 240)
                .overlay(
                    Circle()
                        .fill(Color.init(UIColor.black))
                        .opacity(0.8)
                        .frame(width: 100, height: 100)
                        //.shadow(color: colorScheme == .dark ? .white : .black, radius: 2, x: colorScheme == .dark ? 0 : 2, y: 2)
                        .shadow(color: .black, radius: 2, x: 2, y: 2)
                        .overlay(
                            Text("$\(String(format: "%.2f" ,food.foodPrice))").foregroundColor(.white).font(.system(size: 28, weight: Font.Weight.heavy, design: Font.Design.rounded))
                        )
                        .offset(x: 120, y: -120)

                )
                .overlay(
                    Text(food.foodName)
                        .font(.system(size: 25, weight: Font.Weight.bold, design: Font.Design.rounded))
                        .frame(width: 240, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.init(UIColor.black).opacity(0.4))
                        //.mask(LinearGradient(gradient: fade, startPoint: .leading, endPoint: .trailing))
                        .multilineTextAlignment(.center)
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

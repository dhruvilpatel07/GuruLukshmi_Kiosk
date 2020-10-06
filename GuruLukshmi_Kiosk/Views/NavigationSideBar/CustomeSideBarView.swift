//
//  CustomeSideBarView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import SwiftUI

/// # Delete this file if not using at the end 
struct CustomeSideBarView: View {
    var category: FoodCategory
    let fade =  Gradient(colors: [Color.black, Color.clear])
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(category.categoryImage).resizable().frame(width: 100)
                    .mask(LinearGradient(gradient: fade, startPoint: .leading, endPoint: .trailing))
                Text(category.foodType).fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            
        }.frame(width: 300, height: 80)
        .background(Color.black)
    }
}

struct CustomeSideBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomeSideBarView(category: testFoodCategory[0])
    }
}

//
//  ContentView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-20.
//

import SwiftUI

struct ContentView: View {
    
   // var categoryList = TestDatabase().arrayOfCategory
    @ObservedObject var db = DatabaseConnection()
    var body: some View {
        NavigationView{
        ZStack{
            Color.black.opacity(0.9).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Menu").foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                
                //Spacer()
                List{
                    ForEach(self.db.arrayOfCategory, id: \.self){ category in
                        NavigationLink(
                            destination: FoodListByCategory(category: category)){
                            Text(category.foodType)
                            }
                        
                        }
                    }
                }
            }
        .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad Pro (12.9-inch) (4th generation)")
    }
}

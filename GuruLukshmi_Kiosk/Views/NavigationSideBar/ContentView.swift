//
//  ContentView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-20.
//

import SwiftUI
import LocalAuthentication

/// # Home page where food category is displayed
struct ContentView: View {
    @ObservedObject var db = DatabaseConnection()
    @AppStorage("log_Status") var status = false
    @StateObject var model = UserObjectModelData()
    
    var body: some View {
        
        if status {
            NavigationView{
                
                ZStack{
                    Color.black.opacity(0.9).edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("Menu").foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                        Button(action: model.logOut, label: {
                            Text("LogOut")
                                .foregroundColor(.orange)
                                .fontWeight(.bold)
                        })
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
        else{
            LoginView(model: model)
        }
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad Pro (12.9-inch) (4th generation)")
    }
}

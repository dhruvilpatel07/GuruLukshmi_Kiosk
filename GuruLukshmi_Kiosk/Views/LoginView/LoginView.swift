//
//  LoginView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-10-10.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var model : UserObjectModelData
    var body: some View {
        ZStack{
            Color.newPrimaryColor.opacity(0.4).edgesIgnoringSafeArea(.all)
            VStack{
                
                Spacer(minLength: 0)
                
                ZStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 500, height: 400)
                }
                    .padding(.horizontal)
                    .padding(.vertical,20)
                    .cornerRadius(30)

                
                VStack(spacing: 20){
                    CustomTextFieldView(image: "person", placeHolder: "User ID", txt: $model.userId)
                    
                    CustomTextFieldView(image: "lock", placeHolder: "Password", txt: $model.password)
                }
                .padding(.top)
                Button(action: model.login) {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundColor(.newPrimaryColor)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top,20)
                
                Spacer(minLength: 0)
            }
            //if model.isLoading{
              //  LoadingView()
            //}
        }
        .background(LinearGradient(gradient: .init(colors: [Color.newPrimaryColor,Color.newSecondaryColor]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok")))
        })
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(model: UserObjectModelData())
    }
}

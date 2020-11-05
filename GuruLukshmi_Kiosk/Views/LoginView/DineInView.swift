//
//  DineInView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-11-03.
//

import SwiftUI

struct DineInView: View {
    @StateObject var model = UserObjectModelData()
    @EnvironmentObject var enviromentObj : GlobalVariables
   // @EnvironmentObject var enviromentObj : GlobalVariables
    @AppStorage("log_Table_Number") var tableNumber = 0
    @State var isSelected = false
    @State var col = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    var body: some View {
        VStack{
            if !isSelected{
                ScrollView{
                    LazyVGrid(columns: col, spacing: 15){
                        ForEach(1..<9) { x in
                            
                            Image("table").resizable()
                                .frame(width: 200, height: 180)
                                .overlay(
                                    Text("\(x)")
                                        .font(.largeTitle).bold()
                                        .offset(x: 0, y: -30)
                                ).onTapGesture {
                                    tableNumber = x
                                    self.isSelected.toggle()
                                }
                        }
                    }
                    
                }
            }else{
                ContentView(payments: PaymentGateway(coder: NSCoder())!)
            }
        }.padding(.horizontal, 200)
        .padding(.top, 100)
    }
}

struct DineInView_Previews: PreviewProvider {
    static var previews: some View {
        DineInView().environmentObject(GlobalVariables())
    }
}

//
//  FoodListByCategory.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import SwiftUI

struct FoodListByCategory: View {
    @EnvironmentObject var enviromentObj : GlobalVariables

    let columns = [
       GridItem(.adaptive(minimum: 230))
    ]
    @ObservedObject var db = DatabaseConnection()
    var category : FoodCategory
    var foodList = testData
    @State var tempFood : Food = testData[0]
    @State private var showModal = false
    @State private var showAlert = false
    var body: some View {
        VStack {
            HStack {
                    Spacer()
                    ScrollView {
                         LazyVGrid(columns: columns, spacing: 80) {
                             ForEach(foodList, id: \.self) { food in
                                if self.category.foodType == food.foodType.rawValue{
                                    CustomImageView(food: food)
                                    .onTapGesture {
                                            self.showModal.toggle()
                                        print(tempFood.foodName)
                                        self.enviromentObj.food = food
                                        print(tempFood)
                                    }.sheet(isPresented: self.$showModal){
                                        ModalView(showModal: self.$showModal)
                                    }
                                }
                                    
                             }
                         }
                         .padding(.trailing)
                         .padding(.leading, -20)
                    }.padding(.top, 80).frame(width: 680)
                    
                    VStack {
                        Text("Cart").font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                        
                        ForEach(self.enviromentObj.foodInCart, id: \.self) { order in
                            Text(order.foodName).foregroundColor(.white).font(.largeTitle).bold()
                            Text("Quantity: \(order.foodQuantity)").foregroundColor(.white).font(.headline)
                            
                        }
                        .padding(.top)
                        Spacer()
                        Button(action: {
                            if self.enviromentObj.foodInCart.count > 0{
                                
                                for order in self.enviromentObj.foodInCart{
                                    self.db.addOrders(order)
                                }
                                self.enviromentObj.foodInCart.removeAll()
                                print("Successfully added to database")
                            }else{
                                self.showAlert = true
                            }
                        }){
                            Text("Place Order").foregroundColor(.black).font(.largeTitle).padding()
                                .background(Color.gray)
                        }.alert(isPresented: $showAlert){
                            Alert(title: Text("Cart is Empty"), dismissButton: .default(Text("OK")))
                        }
                        .padding(.bottom, 30)
                    }.frame(width: 300)
                    //.edgesIgnoringSafeArea(.all)
                    .background(Color.newAddToCartColot.opacity(0.1))
                    //Spacer()
            }.edgesIgnoringSafeArea(.all)
            Spacer()
        }
        .padding(.top)
        .background(Color.newSecondaryColor)
        .edgesIgnoringSafeArea(.all)
       /* ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(foodList, id: \.self) { food in
                    Image(food.categoryImgName).resizable()
                        .frame(width: 200, height: 200)
                }
            }
            .padding(.horizontal)
        }*/
    }
}

struct FoodListByCategory_Previews: PreviewProvider {
    static var previews: some View {
        FoodListByCategory(category: testFoodCategory[0]).environmentObject(GlobalVariables())
    }
}

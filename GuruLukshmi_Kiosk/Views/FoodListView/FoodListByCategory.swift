//
//  FoodListByCategory.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import SwiftUI

struct FoodListByCategory: View {
    // MARK: - Variables and Properties 
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
    @State var arrayOfListOfOrder = [ListOfOrder]()
    @State var index = 0
    var body: some View {
        VStack {
            HStack {
                    Spacer()
                // MARK: = Displaying Foods in 2 Rows
                    ScrollView {
                         LazyVGrid(columns: columns, spacing: 80) {
                             ForEach(foodList, id: \.self) { food in
                                if self.category.foodType == food.foodType.foodType{
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
                    
                // MARK: - Cart Section
                    VStack {
                        HStack {
                            Text("Your order").font(.system(size: 20, weight: Font.Weight.medium, design: Font.Design.rounded))
                                .foregroundColor(.white)
                                
                            Spacer()
                            
                            Text("Edit").font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.rounded))
                                .foregroundColor(.white)
                                .padding(.trailing)
                            
                        }.padding(.top, 80)
                        .padding(.horizontal)

                        // Fetching the order from enviromental objects
                        ForEach(self.enviromentObj.foodInCart, id: \.self) { order in
                            HStack(alignment: .center, spacing: 25.0) {
                                Image(order.foodRefrence.foodType.categoryImage).resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
                                //Spacer()
                                Text("X  \(order.foodQuantity)").foregroundColor(.white)
                                    .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                                
                                VStack(spacing: 5.0){
                                    Text(order.foodRefrence.foodName).foregroundColor(.gray).font(.system(size: 20, weight: Font.Weight.medium, design: Font.Design.rounded))
                                        .multilineTextAlignment(.center)
                                    Text("$8.50").foregroundColor(.white).font(.system(size: 15, weight: Font.Weight.medium, design: Font.Design.rounded))
                                
                                }.frame(width: 130)
                                
                                Image(systemName: "trash").foregroundColor(.red)
                                    .onTapGesture {
                                        //Find the first occurance of object in array and returns its index
                                        self.index = self.enviromentObj.foodInCart.firstIndex(where: {$0 == order})!
                                        enviromentObj.foodInCart.remove(at: self.index)
                                    }
                            }
                        }
                        .padding(.top)
                        Spacer()
                        Button(action: {
                            
                            //Placing order and adding the order in firebase database
                            if self.enviromentObj.foodInCart.count > 0{
                                
                                for order in self.enviromentObj.foodInCart{
                                    arrayOfListOfOrder.append(order)
                                }
                                //Setting up the array of order and adding it to database
                                var dummyOrder = Orders()
                                dummyOrder.listOfOrder = self.arrayOfListOfOrder
                                self.db.addOrders(dummyOrder)
                                
                                //Clearing out the cart after the order has been placed
                                self.enviromentObj.foodInCart.removeAll()
                                print("Successfully added to database")
                            }else{
                                self.showAlert = true
                            }
                        }){
                            Text("Place Order").foregroundColor(.black).font(.largeTitle).padding()
                                .background(Color.green.opacity(0.9)).cornerRadius(20).shadow(color: .white, radius: 10)
                                
                        }
                        .alert(isPresented: $showAlert){
                            Alert(title: Text("Cart is Empty"), dismissButton: .default(Text("OK")))
                        }
                        .padding(.bottom, 30)
                    }.frame(width: 350)
                    //.edgesIgnoringSafeArea(.all)
                    .background(Color.newAddToCartColot.opacity(0.1))
                    //Spacer()
            }.edgesIgnoringSafeArea(.all)
            Spacer()
        }
        .padding(.top)
        .background(Color.newSecondaryColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct FoodListByCategory_Previews: PreviewProvider {
    static var previews: some View {
        FoodListByCategory(category: testFoodCategory[0]).environmentObject(GlobalVariables())
    }
}

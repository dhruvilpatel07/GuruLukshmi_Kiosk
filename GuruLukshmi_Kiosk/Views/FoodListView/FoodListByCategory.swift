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
    //@ObservedObject var testDB = TestDatabase()
    var category : FoodCategory
    var foodList = testData
    @State var tempFood : Food = testData[0] // MARK: - Check ME
    @State private var showModal = false
    @State private var showAlert = false
    @State var arrayOfListOfOrder = [ListOfOrder]()
    @State var index = 0
    let fade =  Gradient(colors: [Color.black, Color.clear])
    
    //@State var indexAddMoreFood = 0
    

    var body: some View {
        VStack {
            HStack {
                
                    Spacer()
                // MARK: - Displaying Foods in 2 Rows
                VStack {
                    if self.category.foodType == "Dosa"{
                        NavigationLink(destination: Text("Customize Dosa")) {
                        
                        HStack {
                            Image("dosa").resizable()
                                .mask(LinearGradient(gradient: fade, startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                                .frame(width: 340, height: 200)
                            
                            VStack {
                                Text("Customize Your Own\n Dosa").foregroundColor(.orange)
                                    .font(.system(size: 30, weight: Font.Weight.medium, design: Font.Design.rounded))
                                    .multilineTextAlignment(.center)
                                Text("- Staring from $9.99").font(.system(size: 15, weight: Font.Weight.medium, design: Font.Design.rounded))
                                    .foregroundColor(.white)
                            }

                        
                        }
                        }
                    }
                    Spacer(minLength: 0)
                    ScrollView {
                             LazyVGrid(columns: columns, spacing: 80) {
                                ForEach(self.db.arrayOfFoodList, id: \.self) { food in
                                    if self.category.foodType == food.foodType{
                                        CustomImageView(food: food)
                                        .onTapGesture {
                                                self.showModal.toggle()
                                           // print(tempFood.foodName)
                                            self.enviromentObj.food = food
                                           // print(tempFood)
                                        }.sheet(isPresented: self.$showModal){
                                            ModalView(showModal: self.$showModal)
                                        }
                                    }
                                        
                                 }
                             }
                             .padding(.trailing)
                             
                             .padding(.top, self.category.foodType == "Dosa" ? 80 : 0)
                             .padding(.leading, -20)
                    }.padding(.top, 80).frame(width: 680)
                    
                }
                .padding(.top, 20)
                    
                // MARK: - Cart Section
                    VStack {
                        HStack {
                            Text("Your order").font(.system(size: 20, weight: Font.Weight.medium, design: Font.Design.rounded))
                                .foregroundColor(.white)
                                
                            Spacer()

                        }.padding(.top, 80)
                        .padding(.horizontal)
                        
                       

                        // Fetching the order from enviromental objects
                        ForEach(self.enviromentObj.foodInCart, id: \.self) { order in
                            HStack(alignment: .center, spacing: 25.0) {
                                Image(order.foodRefrence.categoryImage).resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
                                //Spacer()
                                HStack(spacing: -1.0) {
                                    Text("X  ").foregroundColor(.white)
                                        .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                                    
                                    VStack(spacing: 2.0) {
                                        Image(systemName: "arrow.up.circle.fill").foregroundColor(.green)
                                            .onTapGesture{
                                                self.index = self.enviromentObj.foodInCart.firstIndex(where: {$0 == order})!
                                                self.enviromentObj.foodInCart[index].foodQuantity += 1
                                                self.enviromentObj.subTotal += 8.50
                                            }
                                        Text("\(order.foodQuantity)").foregroundColor(.white)
                                            .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                                        Image(systemName: "arrow.down.circle.fill").foregroundColor(.red)
                                            .onTapGesture{
                                                self.index = self.enviromentObj.foodInCart.firstIndex(where: {$0 == order})!
                                                self.enviromentObj.foodInCart[index].foodQuantity -= 1
                                                if order.foodQuantity > 1 {
                                                    self.enviromentObj.subTotal -= 8.50
                                                }
                                                if order.foodQuantity <= 1{
                                                    self.enviromentObj.foodInCart[index].foodQuantity = 1
                                                }
                                            }
                                    }
                                    
                                }
                                
                                VStack(spacing: 5.0){
                                    Text(order.foodRefrence.foodName).foregroundColor(.gray).font(.system(size: 20, weight: Font.Weight.medium, design: Font.Design.rounded))
                                        .multilineTextAlignment(.center)
                                    Text("$8.50").foregroundColor(.white).font(.system(size: 15, weight: Font.Weight.medium, design: Font.Design.rounded))
                                
                                }.frame(width: 130)
                                
                                Image(systemName: "trash").foregroundColor(.red)
                                    .onTapGesture {
                                        //Find the first occurance of object in array and returns its index
                                        self.index = self.enviromentObj.foodInCart.firstIndex(where: {$0 == order})!
                                        self.enviromentObj.subTotal -= (Double(self.enviromentObj.foodInCart[index].foodQuantity) * 8.50)
                                        enviromentObj.foodInCart.remove(at: self.index)
                                    }
                            }
                        }
                        .padding(.top)
                        Spacer()
                        Text("Total $ \(String(format: "%.2f" ,self.enviromentObj.subTotal))")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: Font.Weight.bold, design: Font.Design.rounded))
                        // MARK: - Adding to database (Place order btn)
                        Button(action: {
                          
                            /*for food in testData{
                                self.db.addFoods(food)
                            }*/
                           
                            
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
                                self.enviromentObj.subTotal = 0.0
                                print("Successfully added to database")
                            }else{
                                self.showAlert = true
                            }
                        }){
                            Text("Place Order").foregroundColor(.black).font(.largeTitle).padding()
                                .background(Color.green.opacity(0.9)).cornerRadius(20)//.shadow(color: .white, radius: 10)
                                
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

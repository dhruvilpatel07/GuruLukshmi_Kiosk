//
//  FoodListByCategory.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-21.
//

import SwiftUI

struct FoodListByCategory: View {
    // MARK: - Variables and Properties
    
    let columns = [
        GridItem(.adaptive(minimum: 230))
    ]
    let fade =  Gradient(colors: [Color.black, Color.clear])
    var category : FoodCategory
    
    @EnvironmentObject var enviromentObj : GlobalVariables
    @ObservedObject var db = DatabaseConnection()
    @ObservedObject var model : UserObjectModelData
    
    @State private var showModal = false
    @State private var showAlert = false
    @State var arrayOfListOfOrder = [ListOfOrder]()
    @State var index = 0
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                VStack {
                    // Disaplying Customize your own dosa button only if the selected category is Dosa
                    if self.category.foodType == "Dosa"{
                        NavigationLink(destination: CustomizeYourOwnDosa()) {
                            
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
                    
                    // MARK: - Displaying Foods in 2 Rows
                    /// Displaying list of food is LazyVGrid View
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 80) {
                            ForEach(self.db.arrayOfFoodList, id: \.self) { food in
                                
                                //Condition to display only the foods which is assigned to particular category
                                if self.category.foodType == food.foodType{
                                    CustomImageView(food: food)
                                        
                                        //adding the selected food object global variable and displaying modal view
                                        .onTapGesture {
                                            self.showModal.toggle()
                                            self.enviromentObj.food = food
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
                    ScrollView(.vertical, showsIndicators: false){
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
                                
                                // MARK: - Edit Section
                                /// Edit Section -> adding / subtracting  foodQuantity and  subTotal
                                HStack(spacing: -1.0) {
                                    Text("X  ").foregroundColor(.white)
                                        .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                                    
                                    VStack(spacing: 2.0) {
                                        
                                        //Adding food quantity and increasing subTotal depending on quntity
                                        Image(systemName: "arrow.up.circle.fill").foregroundColor(.green)
                                            .onTapGesture{
                                                self.index = self.enviromentObj.foodInCart.firstIndex(where: {$0 == order})!
                                                self.enviromentObj.foodInCart[index].foodQuantity += 1
                                                self.enviromentObj.subTotal += order.foodRefrence.foodPrice
                                            }
                                        
                                        //Disaply quantity number
                                        Text("\(order.foodQuantity)").foregroundColor(.white)
                                            .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                                        
                                        //Subtracting food quantity and decreasing subTotal depending on quntity
                                        //addind condition to check if the order quantity isn't going into negative
                                        Image(systemName: "arrow.down.circle.fill").foregroundColor(.red)
                                            .onTapGesture{
                                                self.index = self.enviromentObj.foodInCart.firstIndex(where: {$0 == order})!
                                                self.enviromentObj.foodInCart[index].foodQuantity -= 1
                                                if order.foodQuantity > 1 {
                                                    self.enviromentObj.subTotal -= order.foodRefrence.foodPrice
                                                }
                                                if order.foodQuantity <= 1{
                                                    self.enviromentObj.foodInCart[index].foodQuantity = 1
                                                }
                                            }
                                    }
                                    
                                }
                                
                                //Displaying Food name and food price
                                VStack(spacing: 5.0){
                                    Text(order.foodRefrence.foodName).foregroundColor(.gray).font(.system(size: 20, weight: Font.Weight.medium, design: Font.Design.rounded))
                                        .multilineTextAlignment(.center)
                                    Text("$\(String(format: "%.2f" ,order.foodRefrence.foodPrice))").foregroundColor(.white).font(.system(size: 15, weight: Font.Weight.medium, design: Font.Design.rounded))
                                    
                                }.frame(width: 130)
                                
                                //Button to delete food from cart
                                Image(systemName: "trash").foregroundColor(.red)
                                    .onTapGesture {
                                        //Find the first occurance of object in array and returns its index
                                        self.index = self.enviromentObj.foodInCart.firstIndex(where: {$0 == order})!
                                        
                                        //subtracting the total food price from subTotal by multiplying foodQuantity and foodPrice
                                        self.enviromentObj.subTotal -= (Double(self.enviromentObj.foodInCart[index].foodQuantity) * self.enviromentObj.foodInCart[index].foodRefrence.foodPrice)
                                        enviromentObj.foodInCart.remove(at: self.index)
                                    }
                            }
                        }
                        .padding(.top)
                    }
                    //Displaying Total
                    Text("Total $ \(String(format: "%.2f" ,self.enviromentObj.subTotal))")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: Font.Weight.semibold, design: Font.Design.rounded))
                    //Displaying Taxes
                    Text("Tax $ \(String(format: "%.2f" ,(self.enviromentObj.subTotal * 0.13)))")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: Font.Weight.semibold, design: Font.Design.rounded))
                    //Displaying/Setting  SubTotal
                    
                    Text("SubTotal $ \(String(format: "%.2f" ,(self.enviromentObj.subTotal * 0.13) + self.enviromentObj.subTotal))")
                        .foregroundColor(Color.newPrimaryColor)
                        .font(.system(size: 30, weight: Font.Weight.bold, design: Font.Design.rounded))
                    
                    // MARK: - Adding to database (Place order btn)
                    /** #Placing order and adding the order in firebase database
                     - Checking condition if the cart is emplty or not to avoid adding empty orders to database
                     */
                    Button(action: {
                        
                        self.enviromentObj.finalTotal = (self.enviromentObj.subTotal * 0.13) + self.enviromentObj.subTotal
                        
                        if self.enviromentObj.foodInCart.count > 0{
                            
                            for order in self.enviromentObj.foodInCart{
                                arrayOfListOfOrder.append(order)
                            }
                            //Setting up the array of order, subTotal and adding it to database
                            var dummyOrder = Orders(isDineIn: self.model.isDineIn)
                            // dummyOrder.isDineIn = self.model.isDineIn
                            dummyOrder.orderSubTotal = self.enviromentObj.finalTotal
                            dummyOrder.listOfOrder = self.arrayOfListOfOrder
                            dummyOrder.tableNumber = self.model.tableNumber
                            self.db.addOrders(dummyOrder)
                            
                            //Clearing out the cart after the order has been placed
                            self.enviromentObj.foodInCart.removeAll()
                            self.enviromentObj.subTotal = 0.0
                            print("Successfully added to database")// -> For debug purpose
                        }else{
                            self.showAlert = true
                        }
                    }){
                        Text("Place Order").foregroundColor(.black).font(.largeTitle).padding()
                            .background(Color.green.opacity(0.9)).cornerRadius(20)
                        
                    }
                    .padding(.bottom, 30)
                    //Displaying alert if cart is empty and order button is pressed
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("Cart is Empty"), dismissButton: .default(Text("OK")))
                    }
                }.frame(width: 350)
                .background(Color.newAddToCartColot.opacity(0.1))
                
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
        FoodListByCategory(category: testFoodCategory[0], model: UserObjectModelData()).environmentObject(GlobalVariables())
    }
}

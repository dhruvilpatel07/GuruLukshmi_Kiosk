//
//  SelectPaymentMethodView.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-11-10.
//

import SwiftUI

struct SelectPaymentMethodView: View {
    @Binding var selected : String
    @Binding var show : Bool
    @EnvironmentObject var enviromentObj : GlobalVariables
    @ObservedObject var db = DatabaseConnection()
    @ObservedObject var model : UserObjectModelData
    @ObservedObject var payments : PaymentGateway
    @ObservedObject var validator = Validator()
    
    @State var customerEmail = ""
    @State var customerName = ""
    @AppStorage("log_Table_Number") var tableNumber = 0
    var data = ["Credit/Debit Card","Apple Pay","PayPal","Cash"]
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            
            Text("Enter Name/Email")
                .font(.title)
                .foregroundColor(Color.init(UIColor.label))
                .padding(.top)
            
            VStack{
                CustomTextFieldForPayment(image: "person", placeHolder: "Enter your name", txt: $customerName)
                CustomTextFieldForPayment(image: "mail", placeHolder: "Enter your email", txt: $customerEmail)
                Text("Need your email to send the receipt")
                    .font(.system(size: 10, weight: Font.Weight.semibold, design: Font.Design.rounded))
                    .foregroundColor(.red)
            }.padding(.leading, -10)
            
            
            if self.customerName != "" && self.customerEmail != ""{
                
                Text("Select Payment Type")
                    .font(.title)
                    .foregroundColor(Color.init(UIColor.label))
                    .padding(.top)
                
                ForEach(data,id: \.self){i in
                    
                    Button(action: {
                        
                        self.selected = i
                        if self.selected == "PayPal"{ print(self.selected) }
                        
                        
                    }) {
                        
                        HStack{
                            
                            Text(i).foregroundColor(Color.init(UIColor.label))
                            
                            Spacer()
                            
                            ZStack{
                                
                                Circle().fill(self.selected == i ? Color.init(UIColor.secondaryLabel): Color.init(UIColor.secondaryLabel)).frame(width: 18, height: 18)
                                
                                if self.selected == i{
                                    
                                    Circle().stroke(Color.green, lineWidth: 4).frame(width: 25, height: 25)
                                }
                            }
                            
                        }.foregroundColor(.black)
                    }.padding(.top)
                    
                }
            }
            HStack{
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    
                    Text("Cancel").padding(.vertical).padding(.horizontal,25).foregroundColor(.white)
                    
                }
                .background(
                    LinearGradient(gradient: .init(colors: [Color.black,Color.red]), startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(Capsule())
                
                Spacer()
                
                Button(action: {
                    /// Checks if email is valid or not
                    if self.validator.isValidEmail(customerEmail){
                        
                        /// check is payment is selected in PayPal then it takes payment
                        if self.selected == "PayPal"{
                            
                            /// upon success full payment order will be addded to databse
                            self.payments.PayNow(amount: self.enviromentObj.finalTotal) { (sucess) in
                                if sucess{
                                    let newCode = UUID().uuidString.split(separator: "-")[1]
                                    self.enviromentObj.dummyOrderForPayment.cName = self.customerName
                                    self.enviromentObj.dummyOrderForPayment.cEmail = self.customerEmail
                                    self.enviromentObj.dummyOrderForPayment.orderedTimeInString = Date().localizedDescription
                                    self.enviromentObj.dummyOrderForPayment.orderId = String(newCode)
                                    self.enviromentObj.dummyOrderForPayment.tableNumber = self.tableNumber
                                    self.db.addOrders(self.enviromentObj.dummyOrderForPayment)
                                    //Sending Email Transaction Records (Reciept)
                                    
                                    
                                    self.model.sendEmail(foodList: self.enviromentObj.foodInCart, orderTotalAmount: self.enviromentObj.finalTotal, totalBeforeTaxes: self.enviromentObj.subTotal, orderID: String(newCode), cEmail: self.customerEmail, cName: self.customerName)
                                    
                                    //Clearing out the cart after the order has been placed
                                    self.enviromentObj.foodInCart.removeAll()
                                    self.enviromentObj.subTotal = 0.0
                                    print("Successfully added to database")// -> For debug purpose
                                    self.customerName = ""
                                    self.customerEmail = ""
                                    self.selected = ""
                                    self.show.toggle()
                                }
                            }
                        }else{
                            self.show.toggle()
                        }
                    }else{
                        self.showAlert.toggle()
                    }
                    
                }) {
                    
                    Text("Continue").padding(.vertical).padding(.horizontal,25).foregroundColor(Color.init(UIColor.label))
                    
                }
                .alert(isPresented: $showAlert){
                    Alert(title: Text("Please enter valid email address"), dismissButton: .default(Text("OK")))
                }
                .background(
                    
                    self.selected != "" ?
                        
                        LinearGradient(gradient: .init(colors: [Color.green,Color.newSecondaryColor]), startPoint: .leading, endPoint: .trailing) :
                        
                        LinearGradient(gradient: .init(colors: [Color.init(UIColor.secondarySystemBackground),Color.init(UIColor.secondarySystemBackground)]), startPoint: .leading, endPoint: .trailing)
                    
                )
                .clipShape(Capsule())
                .disabled(self.selected != "" ? false : true)
                
                
            }.padding(.top)
            
        }.padding(.vertical)
        .padding(.horizontal,25)
        .padding(.bottom,(UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15)
        .background(Color.init(UIColor.systemBackground))
        .cornerRadius(30)
    }
}


struct SelectPaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPaymentMethodView(selected: .constant("some"), show: .constant(true),model: UserObjectModelData(), payments: PaymentGateway(coder: NSCoder())!).environmentObject(GlobalVariables())
    }
}

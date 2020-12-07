//
//  CustomizeYourOwnDosa.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-10-03.
//

import SwiftUI

struct CustomizeYourOwnDosa: View {
    let fade =  Gradient(colors: [Color.black, Color.clear])
    @State var size = ""
    @State var paste = ""
    @State var spices = ""
    @State var toppings = ""
    @State var spicyLvl = ""
    
    var sizeList = ["Kids", "Small", "Large"]
    var pasteList = ["Chetinad", "Butter garlic", "Maisur", "Maisur bbhaji", "Green chilli", "Pav bhaji","Andhra", "Kaara"]
    var spicesList = ["Jain masala", "Regular masala"]
    var toppingList = ["Tomatoes", "Spring(cabbage-carrot)", "Chilli", "Bell Papers","Ginger","Garlic"]
    var spicyLvlList = ["Mild", "Medium", "Hot"]
    
    @State var price : Double = 0
    @State var foodDescription = ""
    
    @EnvironmentObject var enviromentObj: GlobalVariables
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            Color.init(UIColor.systemFill).edgesIgnoringSafeArea(.all)
            VStack {
                Form{
                    Section(header: Text("SELECT SIZE")) {
                        Picker(selection: $size,
                               label: Text("Size")) {
                            ForEach(self.sizeList, id: \.self) { dosaSize in
                                Text(dosaSize).tag(dosaSize)
                            }
                        }
                    }
                    
                    Section(header: Text("SELECT PASTE")) {
                        Picker(selection: $paste,
                               label: Text("Paste")) {
                            ForEach(self.pasteList, id: \.self) { dosaPaste in
                                Text(dosaPaste).tag(dosaPaste)
                            }
                        }
                    }
                    
                    Section(header: Text("SELECT MASALA")) {
                        Picker(selection: $spices,
                               label: Text("Masala")) {
                            ForEach(self.spicesList, id: \.self) { dosaSpices in
                                Text(dosaSpices).tag(dosaSpices)
                            }
                        }
                    }
                    
                    Section(header: Text("SELECT Toppings")) {
                        Picker(selection: $toppings,
                               label: Text("Toppings")) {
                            ForEach(self.toppingList, id: \.self) { dosaToppings in
                                Text(dosaToppings).tag(dosaToppings)
                            }
                        }
                    }
                    
                    Section(header: Text("SELECT SPICY LEVEL")) {
                        Picker(selection: $spicyLvl,
                               label: Text("Spicy Lvl")) {
                            ForEach(self.spicyLvlList, id: \.self) { dosaLvl in
                                Text(dosaLvl).tag(dosaLvl)
                            }
                        }
                    }
                    
                    if size != "" && paste != "" && spices != "" && toppings != "" && spicyLvl != ""{
                        Section{
                            Button {
                                
                                if size == sizeList[0]{
                                    price += 9.99
                                }else if size == sizeList[1]{
                                    price += 11.99
                                }else{
                                    price += 13.99
                                }
                                
                                self.foodDescription = "Size: \(size)\nPaste: \(paste)\nSpices: \(spices)\nToppings: \(toppings)\nSpicy Lvl: \(spicyLvl)"
                                
                                let food = Food(foodName: "Custom Dosa", foodDescription: self.foodDescription, foodType: "Custom", imgName: "dosa", categoryImage: "Dosa", foodPrice: self.price)
                                
                                self.enviromentObj.foodInCart.append(ListOfOrder(foodRefrence: food, foodQuantity: 1))
                                self.enviromentObj.subTotal += self.price
                                
                                
                                self.size = ""
                                self.paste = ""
                                self.spices = ""
                                self.toppings = ""
                                self.spicyLvl = ""
                                self.mode.wrappedValue.dismiss()
                                
                            } label: {
                                Text("Add to cart").foregroundColor(.green)
                            }
                        }
                    }
                }
                Spacer()
                
            }
            
        }
    }
}

struct CustomizeYourOwnDosa_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeYourOwnDosa().environmentObject(GlobalVariables())
    }
}

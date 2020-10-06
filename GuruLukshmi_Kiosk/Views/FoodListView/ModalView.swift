//
//  ModalView.swift
//  GuruLukshmi
//
//  Created by Dhruvil Patel on 2020-09-04.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import SwiftUI
import SceneKit

struct ModalView: View {
    // MARK: - Properties and Variables
    let fade = Gradient(colors: [.clear ,Color.black, Color.clear])
    var itemStringArray = ["item", "items"]
    
    @Binding var showModal: Bool
    @State var counter = 1
    @EnvironmentObject var enviromentObj: GlobalVariables
    @State var additionalDetail = ""
    @State var itemString = "item"


    // MARK: - Body
    var body: some View {
        
        ZStack{
            
            Color.newSecondaryColor.edgesIgnoringSafeArea(.all)
            VStack {
                
                //Display food image
                Image(self.enviromentObj.food.imgName).resizable()
                    .frame(width: UIScreen.main.bounds.size.width ,height: 450)
                    .mask(LinearGradient(gradient: fade, startPoint: .top, endPoint: .bottom))
                //SceneView(scene: SCNScene(named: "DosaARModel.usdz"), options: [ .autoenablesDefaultLighting, .allowsCameraControl])
                  //  .frame(width: UIScreen.main.bounds.size.width ,height: 480)
                    //.mask(LinearGradient(gradient: fade, startPoint: .top, endPoint: .bottom))
                
                //Display food name
                Text(self.enviromentObj.food.foodName)
                    .font(.system(size: 60, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .foregroundColor(.newPrimaryColor)
                .offset(x: 0, y: -20)
                   .padding()
                
                //Display food description
                Text(self.enviromentObj.food.foodDescription)
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
                    .padding(.horizontal)
                    .frame(width: 600)
                    .multilineTextAlignment(.center)
                    .offset(x: 0, y: -40)

                //This is the custom textView works like textArea. It allows user to type in muiltLine
                MultiLineTextField(txt: $additionalDetail).cornerRadius(10).padding()
                    .frame(width: 600, height: 150)
                    

                // MARK: - Quantity and counter func
                VStack {
                    Text("Quantity").foregroundColor(.gray)
                    
                    //setting up quntity feature
                    HStack{
                        Group{
                           
                            //Condition to avoid quintity to go in negitive number
                           Image(systemName: "minus.circle").onTapGesture {
                             self.counter -= 1
                             if self.counter <= 0{
                                 self.counter = 1
                                }
                            if self.counter == 1 {
                                self.itemString = self.itemStringArray[0]
                            }
                             }.foregroundColor(self.counter == 1 ? .gray : .white) //kinda make button look disable
                             
                            Text("\(counter)").padding(.horizontal).foregroundColor(.newPrimaryColor)

                            Image(systemName: "plus.circle").onTapGesture {
                                   self.counter += 1
                                if self.counter > 1 {
                                    self.itemString = self.itemStringArray[1]
                                }
                               }.foregroundColor(.white)
                        }.font(.largeTitle)
                    }
                }
                Spacer()
                // MARK: - Add to cart button
                /** # adding food object in global variable foodInCart array and changing subTotal depending on quantity
                 */
                Button(action: {
                    
                    //Appending the each oreder in-side of globalVariables foodInCart array
                    self.enviromentObj.foodInCart.append(ListOfOrder(foodRefrence: self.enviromentObj.food, foodQuantity: self.counter))
                    self.enviromentObj.subTotal += (Double(self.counter) * self.enviromentObj.food.foodPrice)
                    
                    
                    //For debug purpose
                    for food in self.enviromentObj.foodInCart{
                        print("IN CART: - \(food)")
                    }
                    self.showModal.toggle()
 
                }) {
                    HStack {
                       Image("addCart")
                        .renderingMode(.original)
                        .font(.title)
                        Text("Add \(counter) \(itemString)")
                           .fontWeight(.semibold)
                           .font(.title)
                    }
                }.buttonStyle(GradientBackgroundStyle())
                .frame(width: 600)
                Spacer()
                
            }
        }.onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            print("In Side Modal :\(enviromentObj.food.foodName)") //For Debug Purpose
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(showModal: .constant(true)).environmentObject(GlobalVariables())
    }
}

/// This stuct creats custome background color
struct GradientBackgroundStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [ Color.newPrimaryColor, Color.newSecondaryColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}


/// Creaeting custome Multi Line Textfield like textArea in web
struct MultiLineTextField: UIViewRepresentable {
    
    @Binding var txt : String
    @State var counter = 0
    
    /// setting up the target
    /// - Returns: the cordinate/ target where changes has to made
    func makeCoordinator() -> Coordinator {
        return MultiLineTextField.Coordinator(parent1: self)
    }
    
    /// Giving the style for custome textView
    /// - Parameter context: where those style belongs
    /// - Returns: TextView
    func makeUIView(context: UIViewRepresentableContext<MultiLineTextField>) -> UITextView {
        
        let tView = UITextView()
        tView.isEditable =  true
        tView.isUserInteractionEnabled = true
        tView.isScrollEnabled = true
        tView.text = "Special Instructions/Note, Additional charges may apply"
        tView.textColor = .gray
        tView.backgroundColor = .white
        tView.font = .systemFont(ofSize: 15)
        tView.delegate = context.coordinator
        return tView
    }
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTextField>) {
        
    }
    
    /// location where those changes/ style belongs
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent : MultiLineTextField
        
        /// init method
        /// - Parameter parent1: getting the parent struct
        init(parent1 : MultiLineTextField) {
            parent = parent1
        }
        
        /// setting parent text from textView when its changed
        /// - Parameter textView: <#textView description#>
        func textViewDidChange(_ textView: UITextView) {
            self.parent.txt = textView.text
        }
        
        /// changes when the user start typing
        /// - Parameter textView: textView object
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.counter == 0 {
                textView.text = ""
                self.parent.counter += 1
            }
            textView.textColor = .black
        }
    }
}

#if canImport(UIKit)
extension View {
    /// To hide the keyboard when user touches outside of keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

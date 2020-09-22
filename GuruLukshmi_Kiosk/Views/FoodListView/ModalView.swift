//
//  ModalView.swift
//  GuruLukshmi
//
//  Created by Dhruvil Patel on 2020-09-04.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import SwiftUI

struct ModalView: View {
    // MARK: - Properties and Variables
    @Binding var showModal: Bool
    @State var counter = 1
    let fade =  Gradient(colors: [.clear ,Color.black, Color.clear])
    @EnvironmentObject var enviromentObj: GlobalVariables
    @State var isFavourite: Bool = false
    @State var additionalDetail = ""
    var itemStringArray = ["item", "items"]
    @State var itemString = "item"
    //@State var addToCartOrder : Orders
    // MARK: - Body
    var body: some View {
        
        ZStack{
            
            Color.newSecondaryColor.edgesIgnoringSafeArea(.all)
            VStack {
                Image(enviromentObj.food.categoryImgName).resizable()
                    .frame(width: UIScreen.main.bounds.size.width ,height: 250)
                    .mask(LinearGradient(gradient: fade, startPoint: .top, endPoint: .bottom))
                
                Text(enviromentObj.food.foodName)
                    .font(.largeTitle)
                    .foregroundColor(.newPrimaryColor)
                .offset(x: 0, y: -30)
                   .padding()
                
                Text(enviromentObj.food.foodDescription)
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.horizontal)
                    .offset(x: 0, y: -30)

                MultiLineTextField(txt: $additionalDetail).cornerRadius(10).padding()
                    .frame(width: 380, height: 150)
                    

                // MARK: - Quantity and counter func
                VStack {
                    Text("Quantity").foregroundColor(.gray)
                    HStack{
                        Group{
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
                Button(action: {
                    self.enviromentObj.foodInCart.append(Orders(foodName: enviromentObj.food.foodName, foodQuantity: self.counter))
                    print(Orders(foodName: enviromentObj.food.foodName, foodQuantity: self.counter))
                    for food in enviromentObj.foodInCart{
                        print("IN CART: - \(food)")
                    }
                    self.showModal.toggle()
                    // prints order for debug purpose
 
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
                Spacer()
                
            }.overlay(
                Image(systemName: self.isFavourite ? "heart.fill" : "heart").onTapGesture {
                    self.isFavourite.toggle()
                }
                    .font(.largeTitle)
                .foregroundColor(self.isFavourite ? .red : .white)
                .offset(x: 160, y: -350)
            )
        }.onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            print("In Side Modal :\(enviromentObj.food.foodName)")
            self.isFavourite = self.enviromentObj.food.favourite
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(showModal: .constant(true)).environmentObject(GlobalVariables())
    }
}

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


struct MultiLineTextField: UIViewRepresentable {
    
    @Binding var txt : String
    @State var counter = 0
    
    func makeCoordinator() -> Coordinator {
        return MultiLineTextField.Coordinator(parent1: self)
    }
    
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
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent : MultiLineTextField
        
        init(parent1 : MultiLineTextField) {
            parent = parent1
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.txt = textView.text
        }
        
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
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

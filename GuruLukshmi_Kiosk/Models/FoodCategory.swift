//
//  FoodCategory.swift
//  GuruLukshmi
//
//  Created by Dhruvil Patel on 2020-09-02.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FoodCategory: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var foodType: String
    var categoryImage: String
    //var categoryImg
    /*enum Category: String, CaseIterable, Codable, Hashable {
        case appetizers = "Appetizers"
        case indianBreads = "Indian Breads"
        case idly = "Idly"
        case dosa = "Dosa"
        case signatureDosa = "Signature Dosa"
        case dessert = "Dessert"
    }*/
}

//Beverages
#if DEBUG
let testFoodCategory = [
    FoodCategory(foodType: "Appetizers", categoryImage: "Appetizers"),
    FoodCategory(foodType: "Dosa", categoryImage: "Dosa"),
    FoodCategory(foodType: "Signature Dosa", categoryImage: "SignatureDosa"),
    FoodCategory(foodType: "Idly", categoryImage: "Idly"),
    FoodCategory(foodType: "Uthapams", categoryImage: "Uthapam"),
    FoodCategory(foodType: "Lunch Items", categoryImage: "LunchItem"),
    FoodCategory(foodType: "Indian Breads", categoryImage: "IndianBread"),
    FoodCategory(foodType: "Dessert", categoryImage: "Dessert"),
    FoodCategory(foodType: "Beverages", categoryImage: "Beverages"),
    FoodCategory(foodType: "Side Dish", categoryImage: "SideDish")

    
    
]
#endif


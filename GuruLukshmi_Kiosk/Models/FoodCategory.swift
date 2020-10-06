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

/// # Category Model which includes categroy type and it's image
struct FoodCategory: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var foodType: String
    var categoryImage: String
}

//Category data which is now in database
#if DEBUG
let testFoodCategory = [
    FoodCategory(foodType: "Appetizers", categoryImage: "Appetizers"),
    FoodCategory(foodType: "Dosa", categoryImage: "Dosa"),
    FoodCategory(foodType: "Signature Dosa", categoryImage: "SignatureDosa"),
    FoodCategory(foodType: "Idly", categoryImage: "Idly"),
    FoodCategory(foodType: "Uthapams", categoryImage: "Uthapam"),
    FoodCategory(foodType: "Rice", categoryImage: "Rice"),
    FoodCategory(foodType: "Indian Breads", categoryImage: "IndianBread"),
    FoodCategory(foodType: "Dessert", categoryImage: "Dessert"),
    FoodCategory(foodType: "Beverages", categoryImage: "Beverages"),
    FoodCategory(foodType: "Side Dish", categoryImage: "SideDish")
]
#endif


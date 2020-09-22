//
//  Food.swift
//  GuruLukshmi
//
//  Created by Dhruvil Patel on 2020-08-30.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import Foundation

struct Food: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    var foodName: String
    var foodDescription: String
    var foodType: Category
    var foodSubCategory: String?
    var imgName: String
    var categoryImgName: String
    var favourite: Bool
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case appetizers = "Appetizers"
        case indianBreads = "Indian Breads"
        case idly = "Idly"
        case dosa = "Dosa"
        case signatureDosa = "Signature Dosa"
        case dessert = "Dessert"
    }
}



#if DEBUG
let testData = [
    // MARK: - Appetizers
  Food(foodName: "Chilli Bajji (Pakora)", foodDescription: "Deep fried mild chillies coated with mildly spiced chick pea batter served with coconut and coriander chutney",  foodType: .appetizers, foodSubCategory: "Finger Foods" , imgName: "springRoll", categoryImgName: "Appetizers", favourite: true),
    Food(foodName: "Potato Bonda", foodDescription: "Deep fried potato ball fritters served with coconut chutney",  foodType: .appetizers,foodSubCategory: "Finger Foods", imgName: "springRoll", categoryImgName: "Appetizers", favourite: false),
    Food(foodName: "Samosa Plate", foodDescription: "Fried Indian pastry stuffed with flavoured potatoes served with coriander and tamarind chutney", foodType: .appetizers,foodSubCategory: "Finger Foods", imgName: "springRoll", categoryImgName: "Appetizers", favourite: true),
    Food(foodName: "Rava Upma", foodDescription: "Traditional South Indian light meal made with suji/rava (semolina) and spices, served with sambar, cocnut chutney and sugar", foodType: .appetizers, foodSubCategory: "Finger Foods",imgName: "springRoll", categoryImgName: "Appetizers", favourite: true),
    Food(foodName: "Medhu Vada", foodDescription: "Fried lentil flour doughnuts mildly spiced served with sambhar, cocunut chutney and tomato chutney", foodType: .appetizers,foodSubCategory: "Vada", imgName: "springRoll", categoryImgName: "Appetizers", favourite: true),
    Food(foodName: "Sambhar Vada", foodDescription: "Fried lentil flour doughnuts dipped in sambhar, topped with ghee, fresh onions, coriander, and coconut chutney", foodType: .appetizers,foodSubCategory: "Vada", imgName: "springRoll", categoryImgName: "Appetizers", favourite: true),
    Food(foodName: "Rasa Vada", foodDescription: "Lentil doughnuts dipped in rasam and topped with fresh onions and coriander", foodType: .appetizers,foodSubCategory: "Vada", imgName: "springRoll", categoryImgName: "Appetizers", favourite: true),
    Food(foodName: "Salty Dahi (Yogurt) Vada", foodDescription: "Lentil doughnuts soaked in seasoned yoghurt, topped with fresh coriander, boondhi and sweet & spicy tamarind sauce", foodType: .appetizers,foodSubCategory: "Vada", imgName: "springRoll", categoryImgName: "Appetizers", favourite: true),
    Food(foodName: "Sweet Dahi (Yoghurt) Vada", foodDescription: "Lentil doughnuts soaked in sweet seasoned yoghurt, topped with fresh coriander, boondhi and sweet & spicy tamarind sauce", foodType: .appetizers,foodSubCategory: "Vada", imgName: "springRoll", categoryImgName: "Appetizers", favourite: true),
    Food(foodName: "Spicy Rasam", foodDescription: "A South Indian home-made spicy and tangy soup made with lentil, tomato, and tamarind juice flavoured with red chillies, pepper and spices.", foodType: .appetizers,foodSubCategory: "Soup", imgName: "springRoll", categoryImgName: "Appetizers", favourite: true),

    // MARK: - Dosa
    Food(foodName: "Plain Dosa", foodDescription: "A golden thin crepe made of fermented lentil and rice batter",  foodType: .dosa, foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: false),
    Food(foodName: "Aloo Masala Dosa", foodDescription: "A mildly spiced traditional potato and onions stuffing in a plain dosa",  foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Onion Dosa", foodDescription: "Finely chopped sautéed onions topped on dosa and garnished with fresh coriander", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Steam Dosa", foodDescription: "A healthy soft dosa made with no oil", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Set Dosa", foodDescription: "A set of 2 fluffy and spongy dosas cooked with a little butter, topped with some onions, coriander and tomatoes and mild spices", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Paper Dosa", foodDescription: "Larger and crispier version of the plain dosa", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Cheese Dosa", foodDescription: "Rennet free vegetable mozzarella cheese on dosa", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Chilli Cheese Dosa", foodDescription: "Rennet free mozzarella cheese, freshly chopped green chillies and ginger on dosa", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Ghee Dosa", foodDescription: "Delicious homemade clarified butter drizzled on a crispy dosa", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Ghee Paper Dosa", foodDescription: "Extra large and crispy dosa drizzled with homemade clarified butter and rolled to golden perfection", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Butter Dosa", foodDescription: "Crispy dosa drizzled with butter and rolled to golden perfection", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Butter Paper Dosa", foodDescription: "Larger and crispier version of butter dosa", foodType: .dosa,foodSubCategory: "DOSA - BASICS", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Rava Dosa", foodDescription: "Thin and crispy crepe made from semolina and rice batter, topped with fresh ginger and coriander", foodType: .dosa,foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Ghee Rava Dosa", foodDescription: "Thin and crispy crepe made from semolina and rice batter, cooked in ghee (clarified butter) and topped with fresh ginger and coriander", foodType: .dosa,foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Onion Rava Dosa", foodDescription: "Thin crepe made from semolina and rice batter, sprinkled with sautéed onions and topped with ginger and corriander", foodType: .dosa,foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Dry Fruit Rava Dosa", foodDescription: "Thin crepe made from semolina and rice batter, garnished with dry nuts, raisins and topped with ginger and corriander", foodType: .dosa,foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImgName: "Dosa", favourite: true),
    Food(foodName: "Spicy Rava Dosa", foodDescription: "Special herbs and spices added to our semolina and rice batter, for added flavour and kick, this creations is topped with fresh ginger and coriander", foodType: .dosa,foodSubCategory: "DOSA - RAVA", imgName: "dosa", categoryImgName: "Dosa", favourite: true)
    
    
    
    /*
    // MARK: - Signature Dosa
    Food(foodName: "Dosa with Chees", foodDescription: <#String#>,  foodType: .signatureDosa, imgName: "dosaChees", categoryImgName: "SignatureDosa", favourite: true),
    Food(foodName: "Butter Garlic Dosa", foodDescription: <#String#>,  foodType: .signatureDosa, imgName: "dosaChees", categoryImgName: "SignatureDosa", favourite: true),
    
    //-------------------------------------------------Idly-----------------------------------
    Food(foodName: "Idly Sambhar", foodDescription: <#String#>,  foodType: .idly, imgName: "idly", categoryImgName: "Idly", favourite: true),
    Food(foodName: "Spicy Sambhar Idly", foodDescription: <#String#>,  foodType: .idly, imgName: "idly", categoryImgName: "Idly", favourite: false),
    

     //-------------------------------------------------Uthapams-----------------------------------
    
    
    
     //-------------------------------------------------Lunch Items-----------------------------------
    
    
    
     //-------------------------------------------------Indian Breads-----------------------------------
    
    
    //-------------------------------------------------Dessert-----------------------------------
    Food(foodName: "Faluda", foodDescription: <#String#>,  foodType: .dessert, imgName: "faluda", categoryImgName: "Dessert", favourite: false),
    Food(foodName: "Ras Malai", foodDescription: <#String#>,  foodType: .dessert, imgName: "faluda", categoryImgName: "Dessert", favourite: true)
    
    */
    
     //-------------------------------------------------Beverages-----------------------------------
    
    
    
    
     //-------------------------------------------------Side Dish-----------------------------------


]
#endif



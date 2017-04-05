//
//  Models.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/27/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class Restaurant: NSObject {
    var id: String?
    var name: String?
    var details: String?
    var location: String?
    var profileImageUrl: String?
    var email: String?
    var meals: [Meal]?
    var mealsId: [String:String]?
    
    public static func ==(restaurantA: Restaurant, restaurantB: Restaurant) -> Bool{
        return
            restaurantA.id == restaurantB.id
    }
    
}

class Meal: NSObject {
    var id: String?
    var name: String?
    var details: String?
    var imageName: String?
    var mealImageUrl: String?
    var price: String?
    var image: UIImage?
    var weigth: String?
    var restaurantUID: String?
    
    public static func ==(mealA: Meal, mealB: Meal) -> Bool{
        return
            mealA.id == mealB.id
    }
}

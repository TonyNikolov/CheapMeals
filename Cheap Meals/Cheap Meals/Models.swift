//
//  Models.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/27/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class Restaurant: NSObject {
    var name: String?
    var meals: [Meal]?
    
    static func dummyData() -> [Restaurant] {
        let srubskSkara = Restaurant()
        srubskSkara.name = "Srubska skara"
        
        var meals = [Meal]()
        
        let kiuftaci = Meal()
        kiuftaci.name = "Kiuftaci"
        kiuftaci.imageName = "dummyImage3"
        kiuftaci.price = NSNumber(floatLiteral: 0.99)
        
        let pleskavica = Meal()
        pleskavica.name = "Pleskavica"
        pleskavica.imageName = "dummyImage3"
        pleskavica.price = NSNumber(floatLiteral: 2.99)

        
        meals.append(kiuftaci)
        meals.append(pleskavica)
        srubskSkara.meals = meals
        
        let srubskSkara2 = Restaurant()
        srubskSkara2.name = "Srubska skara2"
        
        var meals2 = [Meal]()
        
        let kiuftaci2 = Meal()
        kiuftaci2.name = "Kiuftaci"
        kiuftaci2.imageName = "dummyImage3"
        kiuftaci2.price = NSNumber(floatLiteral: 0.99)
        
        let pleskavica2 = Meal()
        pleskavica2.name = "Pleskavica"
        pleskavica2.imageName = "dummyImage3"
        pleskavica2.price = NSNumber(floatLiteral: 2.99)
        
        
        meals2.append(kiuftaci)
        meals2.append(pleskavica)
        srubskSkara2.meals = meals

        return [srubskSkara, srubskSkara2]
    }
}

class Meal: NSObject {
    var id: String?
    var name: String?
    var imageName: String?
    var price: NSNumber?
}

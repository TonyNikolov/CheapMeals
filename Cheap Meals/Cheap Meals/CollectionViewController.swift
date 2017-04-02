//
//  CollectionViewController.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 4/1/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

extension UICollectionViewController {
    func showMealDetails(meal: Meal){
        //let layout = UICollectionViewFlowLayout()
        let mealDetailController = MealDetailController()
        mealDetailController.meal = meal
        navigationController?.pushViewController(mealDetailController, animated: true)
        
    }
    
    func showRestaurantProfile(restaurant: Restaurant){
        // let layout = UICollectionViewFlowLayout()
        let restaurantProfileController = RestaurantProfileController()
        restaurantProfileController.restaurant = restaurant
        navigationController?.pushViewController(restaurantProfileController, animated: true)
        
    }
}

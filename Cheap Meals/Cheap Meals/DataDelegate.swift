//
//  DataDelegate.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/26/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

protocol DataDelegate {
    func onSuccessLogin()
    func onFailedLogin()
    func onSuccessRegister()
    func onFailedRegister()
    func onSuccessMealPush()
    func onFailedMealPush(error: String)
    func onSuccessRestaurantRecieved(restaurant: Restaurant)
    func onFailedRestaurantRecieved()
    func onSuccesMealRecieved(meal: Meal, forRestaurantUID: String)
    func onRecieveRestaurants(restaurant: Restaurant)
}

extension DataDelegate {
    func onRecieveRestaurants(restaurant: Restaurant){
        
    }
    func onSuccesMealRecieved(meal: Meal, forRestaurantUID: String){
        
    }
    func onSuccessMealPush(){
        
    }
    func onFailedMealPush(error: String){
        
    }
    func onSuccessLogin(){
        
    }
    func onFailedLogin(){
        
    }
    func onSuccessRegister(){
        
    }
    func onFailedRegister(){
        
    }
    func onSuccessRestaurantRecieved(restaurant: Restaurant){
        
    }
    func onFailedRestaurantRecieved(){
        
    }
}

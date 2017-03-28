//
//  File.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/26/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//
import UIKit

protocol DataProtocol {
    func isUserLoggedIn() -> Bool
    func userLogin(withEmail email: String, andPassword password: String)
    func userLogout()
    func userRegister(withEmail email: String, andPassword password: String, andDisplayName name: String)
    func userRegister(withEmail email: String, andPassword password: String, andDisplayName name: String, andProfileImage image: UIImage)
    func getRestaurants()
    }

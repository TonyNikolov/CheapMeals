//
//  ViewController.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/25/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit
import FirebaseAuth

class FeaturedMealsController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "celId"
    var restaurants: [Restaurant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurants = Restaurant.dummyData()
        
        collectionView?.backgroundColor = UIColor(r: 219, g: 80, b: 84)
        collectionView?.register(RestaurantCell.self, forCellWithReuseIdentifier: cellId )
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        
        if data?.isUserLoggedIn() == false {
            perform(#selector(handleLogout), with: nil, afterDelay: 0) 
        }
    }
    
    var data: Data? {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.data
        }
    }
    
    func handleLogout(){
        
        data?.userLogout()
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = restaurants?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RestaurantCell
        cell.restaurant = restaurants?[indexPath.item]
        return cell
    }
    
}


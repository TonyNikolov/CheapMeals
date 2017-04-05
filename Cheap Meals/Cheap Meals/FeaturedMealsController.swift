//
//  ViewController.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/25/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit
import FirebaseAuth

class FeaturedMealsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DataDelegate{
    
    private let cellId = "celId"
    var restaurants: [Restaurant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurants = [Restaurant]()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor(r: 219, g: 80, b: 84)
        collectionView?.register(RestaurantCell.self, forCellWithReuseIdentifier: cellId )
        let logout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let profile = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(handleEditTapped))
        let add = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddTapped))
        navigationItem.rightBarButtonItems = [add]
        navigationItem.leftBarButtonItems = [logout,profile]
        
            }
    
    var data: Data? {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.data
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if data?.isUserLoggedIn() == false {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            data?.delegate = self
            data?.getRestaurants()
        }

    }
    
    func onRecieveRestaurants(restaurant: Restaurant){
        if (self.restaurants?.contains(restaurant))!{
            
        } else{
            self.restaurants?.append(restaurant)
        }
        DispatchQueue.main.async {
            // Run UI Updates
            self.collectionView?.reloadData()
        }
        
    }
    
    func onSuccesMealRecieved(meal: Meal, forRestaurantUID: String){
        for res in self.restaurants! {
            if res.id == forRestaurantUID {
                if(res.meals?.contains(meal))!{
                    
                } else {
                    res.meals?.append(meal)
                }
                break
            }
        }
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        
    }
    
    func handleAddTapped(){
        let addMealController = AddMealController()
        present(UINavigationController(rootViewController: addMealController), animated: true, completion: nil)
    }
    
    func handleEditTapped(){
        if (data?.isUserLoggedIn()) != nil {
            self.data?.delegate = self
            self.data?.getRestaurantById(uid: (data?.getLoggedInUserUID())!)
        } else {
            //load loginc screen
            handleLogout()
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
    
    func onSuccessRestaurantRecieved (restaurant: Restaurant) {
        showRestaurantProfile(restaurant: restaurant)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let rest: Restaurant = restaurants?[indexPath.item] {
            self.data?.delegate = self
            self.data?.getRestaurantById(uid: rest.id!)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RestaurantCell
        cell.restaurant = restaurants?[indexPath.item]
        cell.featuredMealsController = self
        //if you manage to beautify this, you win a gum "turbo"
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 5,
                       options: [],
                       animations: {
                        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: {
                        finished in
                        UIView.animate(withDuration: 1.3, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut,
                                       animations: {
                                        cell.transform = CGAffineTransform(scaleX: 1, y: 1) }, completion: nil )})
        return cell
    }
    
}


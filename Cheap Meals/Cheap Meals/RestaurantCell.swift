//
//  RestaurantCell.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/27/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class RestaurantCell: BaseCell, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    var featuredMealsController: UICollectionViewController?
    private let mealCellId = "mealCellId"
    
    var restaurant: Restaurant? {
        didSet{
            if let name = restaurant?.name {
                nameLabel.text = name
            }
            
            mealsCollectionView.reloadData()
        }
    }
    
    let nameLabel: UIUnderlinedLabel = {
        let nameLabel = UIUnderlinedLabel()
        nameLabel.text = "Srubska skara"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    
    let mealsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func setupCell(){
        backgroundColor = UIColor.clear
        addSubview(mealsCollectionView)
        addSubview(dividerLineView)
        addSubview(nameLabel)
        
        mealsCollectionView.dataSource = self
        mealsCollectionView.delegate = self
        mealsCollectionView.register(MealCell.self, forCellWithReuseIdentifier: mealCellId)

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":mealsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(30)][v0][v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["nameLabel": nameLabel,"v0":mealsCollectionView, "v1": dividerLineView]))
        
        dividerLineView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let meal: Meal = restaurant?.meals?[indexPath.item] {
        featuredMealsController?.showMealDetails(meal: meal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = restaurant?.meals?.count {
            return count
        }
        
        return 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealCellId, for: indexPath) as! MealCell
        cell.meal = (restaurant?.meals?[indexPath.item])!
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.8, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height-32)
    }
    
}

extension Notification.Name {
    static let reload = Notification.Name("reload")
}

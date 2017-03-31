//
//  RestaurantProfileController.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/29/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class RestaurantProfileController: UICollectionViewController, DataDelegate, UICollectionViewDelegateFlowLayout {
    private let headerId = "headerId"
    private var meals: [Meal]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.meals = [Meal]()
        data?.delegate = self
        data?.getMeals(mealsToFind: [String:String]())
        collectionView?.backgroundColor = UIColor(r: 218, g: 80, b: 84)
        collectionView?.register(RestaurantDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.alwaysBounceVertical = true
    }
    
    var restaurant: Restaurant? {
        didSet {
            navigationItem.title = restaurant?.name
        }
    }
    
    var data: Data? {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.data
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! RestaurantDetailHeader
        header.restaurant = restaurant
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func onSuccesMealRecieved(meal: Meal){
        self.meals?.append(meal)
        collectionView?.reloadData()
        print("getting meals, getting money")
    }

}

class RestaurantDetailHeader: BaseCell {
    
    var restaurant: Restaurant? {
        didSet{
//            if let imageName = restaurant?.imageName {
//                imageView.image = UIImage(named: imageName)
//            }
            
            if let nameLb = restaurant?.name {
                nameLabel.text = nameLb
            }
            
        }
    }
    
    let dividerLineView: UIView = {
        let dividerLine = UIView()
        dividerLine.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return dividerLine
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "testing"
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        return nameLabel
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
    let segmentedControll: UISegmentedControl = {
        let sc = UISegmentedControl(items:["Details","Reviews", "Location"])
        sc.tintColor = UIColor.darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    override func setupCell() {
        super.setupCell()
        addSubview(segmentedControll)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-14-[v0(120)]-8-[v1]", views: imageView,nameLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0(120)]", views: imageView)
        addConstraintsWithFormat(format: "V:|-14-[v0(20)]", views: nameLabel)
        
        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentedControll)
        addConstraintsWithFormat(format: "V:[v0(34)]-8-|", views: segmentedControll)
        
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: dividerLineView)
        
        
    }
}


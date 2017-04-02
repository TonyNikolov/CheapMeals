//
//  RestaurantProfileController.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/29/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class RestaurantProfileController: UIViewController, DataDelegate {
    
    private let mealCellId = "mealCellId"
    let restaurantCellId = "restaurantId"
    
    private var restaurantMealDictionary: [String:[Meal]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data?.delegate = self
        data?.getMeals(forRestaurantUID: (restaurant?.id)!)
        view?.backgroundColor = UIColor(r: 218, g: 80, b: 84)
        //collectionView?.alwaysBounceVertical = true
        
        setupCell()
        setupPermissions()
    }
    
    func onSuccesMealRecieved(meal: Meal, forRestaurantUID: String){
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            self.restaurant?.meals?.append(meal)
            DispatchQueue.main.async {
                self.mealsCollectionView.reloadData()
            }
        }
    }
    
    var restaurant: Restaurant? {
        didSet{
            if let nameLb = restaurant?.name {
                nameLabel.text = nameLb
                navigationItem.title = nameLb
            }
            
            if (restaurant?.profileImageUrl) != nil {
                imageView.loadImageUsingCacheWithUrlString(urlString: (restaurant?.profileImageUrl)!)
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
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let segmentedControll: UISegmentedControl = {
        let sc = UISegmentedControl(items:["Details","Meals", "Location"])
        sc.selectedSegmentIndex = 1
        sc.tintColor = UIColor.white
        sc.addTarget(self, action: #selector(handleSegmentedControlChange), for: .valueChanged)
        return sc
    }()
    
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        tf.isHidden = true
        tf.placeholder = "Your address location"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let detailsTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.isHidden = true
        tf.placeholder = "Some details for your establishment"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 219, g: 80, b: 84)
        button.setTitle("Update", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleUpdateAddress), for: .touchUpInside)
        
        return button
    }()
    
    
    let mealsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 16
        collectionView.layer.borderColor = UIColor.white.cgColor
        collectionView.contentInset =  UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return collectionView
        
    }()
    
    
    var data: Data? {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.data
        }
    }
    
    func setupPermissions(){
        
    }
    
    func handleUpdateAddress() {
        
    }
    
    func handleSegmentedControlChange() {
        let title = segmentedControll.titleForSegment(at: segmentedControll.selectedSegmentIndex)
        if(title == "Location"){
            addressTextField.isHidden = false
            detailsTextField.isHidden = true
            mealsCollectionView.isHidden = true
        } else if (title == "Details") {
            addressTextField.isHidden = true
            detailsTextField.isHidden = false
            mealsCollectionView.isHidden = true
        } else {
            addressTextField.isHidden = true
            detailsTextField.isHidden = true
            mealsCollectionView.isHidden = false
        }
    }
    
    func setupCell() {
        view.addSubview(segmentedControll)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(dividerLineView)
        view.addSubview(updateButton)
        view.addSubview(addressTextField)
        view.addSubview(detailsTextField)
        view.addSubview(mealsCollectionView)
        
        setupUpdateAddressButton()
        setupAddressTextField()
        setupDetailsTextField()
        setupMealsCollectionView()
        
        
        view.addConstraintsWithFormat(format: "H:|-14-[v0(120)]-8-[v1]", views: imageView,nameLabel)
        view.addConstraintsWithFormat(format: "V:|-70-[v0(120)]", views: imageView)
        view.addConstraintsWithFormat(format: "V:|-70-[v0(20)]", views: nameLabel)
        
        view.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentedControll)
        view.addConstraintsWithFormat(format: "V:|-200-[v0(34)]", views: segmentedControll)
        
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        view.addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: dividerLineView)
        
        view.addConstraintsWithFormat(format: "H:|-5-[v0(\(view.frame.size.width-10))]-5-|", views: mealsCollectionView)
        view.addConstraintsWithFormat(format: "V:|-250-[v0(180)]", views: mealsCollectionView)
        
        
    }
    
    func setupMealsCollectionView(){
        
        mealsCollectionView.dataSource = self
        mealsCollectionView.delegate = self
//        mealsCollectionView.frame = CGRect(x: 100, y: 200, width: 400, height: 220)
        mealsCollectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: restaurantCellId)
        
    }
    
    func setupUpdateAddressButton(){
        view.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: updateButton)
        view.addConstraintsWithFormat(format: "V:|-300-[v0]", views: updateButton)
        
    }
    
    func setupAddressTextField(){
        view.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: addressTextField)
        view.addConstraintsWithFormat(format: "V:[v0]-10-[v1]", views: segmentedControll, addressTextField)
    }
    
    func setupDetailsTextField(){
        view.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: detailsTextField)
        view.addConstraintsWithFormat(format: "V:[v0]-10-[v1]", views: segmentedControll, detailsTextField)
    }
}

extension RestaurantProfileController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  mealsCollectionView.dequeueReusableCell(withReuseIdentifier: restaurantCellId, for: indexPath) as! RestaurantCell
        cell.restaurant = restaurant
        cell.restaurant?.name = ""
        //cell.featuredMealsController = self
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

extension RestaurantProfileController: UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

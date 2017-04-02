//
//  MealDetailController.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/29/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//
import UIKit

class MealDetailController: UIViewController, DataDelegate {
    
    private let mealCellId = "mealCellId"
    let restaurantCellId = "restaurantId"
    
    private var restaurantMealDictionary: [String:[Meal]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data?.delegate = self
        view?.backgroundColor = UIColor(r: 218, g: 80, b: 84)
        //collectionView?.alwaysBounceVertical = true
        
        setupCell()
        setupPermissions()
    }
    
    
    var meal: Meal? {
        didSet{
            if let nameLb = meal?.name {
                nameLabel.text = nameLb
                navigationItem.title = nameLb
            }
            
            if (meal?.mealImageUrl) != nil {
                imageView.loadImageUsingCacheWithUrlString(urlString: (meal?.mealImageUrl)!)
            }
            
            if let details = meal?.details {
                if !details.isEmpty {
                    detailsTextField.text = "\(details)"
                }
            }
            
            if let price = meal?.price {
                if !price.isEmpty {
                    priceLabel.text = "\(price) BGN"
                }
            }
            
            if let weigth = meal?.weigth {
                if !weigth.isEmpty {
                    weigthLabel.text = "\(weigth) grams"
                }
            }
        }
    }
    
    let dividerLineView: UIView = {
        let dividerLine = UIView()
        dividerLine.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return dividerLine
    }()
    
    let weigthLabel: UILabel = {
        let weigthLabel = UILabel()
        weigthLabel.text = ""
        weigthLabel.textColor = UIColor.white
        weigthLabel.font = UIFont.systemFont(ofSize: 22)
        return weigthLabel
    }()
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "Free"
        priceLabel.textColor = UIColor.green
        priceLabel.font = UIFont.systemFont(ofSize: 22)
        return priceLabel
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "testing"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 22)
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
        let sc = UISegmentedControl(items:["Description","Reviews"])
        sc.selectedSegmentIndex = 0
        sc.tintColor = UIColor.white
        sc.addTarget(self, action: #selector(handleSegmentedControlChange), for: .valueChanged)
        return sc
    }()
    
    let detailsTextField: UITextView = {
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "Short description"
        tf.isUserInteractionEnabled = false
        tf.layer.cornerRadius = 10
        tf.backgroundColor = UIColor.white
        tf.font = UIFont.systemFont(ofSize: 18)
        return tf
    }()
    
    
    var data: Data? {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.data
        }
    }
    
    func setupPermissions(){
    }
    
    func handleUpdateButtonTapped() {
        let title = segmentedControll.titleForSegment(at: segmentedControll.selectedSegmentIndex)
        if(title == "Reviews") {
            
        } else if (title == "Description") {
            
        }
        
    }
    func setupCell() {
        view.addSubview(segmentedControll)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(dividerLineView)
        view.addSubview(weigthLabel)
        view.addSubview(priceLabel)
        view.addSubview(detailsTextField)
        
        view.addConstraintsWithFormat(format: "H:|-14-[v0(120)]-8-[v1]", views: imageView,nameLabel)
        view.addConstraintsWithFormat(format: "H:|-142-[v0]", views: weigthLabel)
        view.addConstraintsWithFormat(format: "V:|-70-[v0(120)]", views: imageView)
        view.addConstraintsWithFormat(format: "V:|-80-[v0]-8-[v1]", views: nameLabel,weigthLabel)
        
        view.addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentedControll)
        view.addConstraintsWithFormat(format: "V:|-200-[v0(34)]", views: segmentedControll)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        view.addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: dividerLineView)
        
        view.addConstraintsWithFormat(format: "H:[v0]-20-|", views: priceLabel)
        view.addConstraintsWithFormat(format: "V:|-150-[v0]", views: priceLabel)
        
        view.addConstraintsWithFormat(format: "H:|-40-[v0(\(view.frame.width-80))]-40-|", views: detailsTextField)
        view.addConstraintsWithFormat(format: "V:[v0]-10-[v1(70)]", views: segmentedControll, detailsTextField)
        
    }
    
    func onFailedValueUpdated(message: String){
        showToast(message: message)
    }
    func onSuccessValueUpdated(message: String){
        showToast(message: message)
    }
    
    
    func handleSegmentedControlChange() {
        let title = segmentedControll.titleForSegment(at: segmentedControll.selectedSegmentIndex)
        if(title == "Reviews"){
            detailsTextField.isHidden = true
        } else if (title == "Description") {
            detailsTextField.isHidden = false
        }
    }
    
}


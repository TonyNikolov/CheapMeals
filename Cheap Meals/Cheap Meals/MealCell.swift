//
//  MealCell.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/27/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class MealCell: BaseCell {
 
    var meal: Meal? {
        didSet{
            if let name = meal?.name {
                nameLabel.text = name
            }
            
            if let price = meal?.price {
                priceLabel.text = "\(price) BGN"
            } else{
                priceLabel.text = "Free"
            }
            
            if (meal?.imageName) != nil {
                imageView.loadImageUsingCacheWithUrlString(urlString: (meal?.mealImageUrl)!)
            }
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dummyImage2")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = UIColor.white
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Kiuftaci"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "0.99 BGN"
        priceLabel.textColor = UIColor.green
        priceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        priceLabel.numberOfLines = 1
        return priceLabel
    }()
    
    override func setupCell(){
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        imageView.frame = CGRect(x: 0, y: 0, width:100, height: 100)
        nameLabel.frame = CGRect(x: 0, y: frame.width+2, width: frame.width, height: 40)
        priceLabel.frame = CGRect(x: 0, y: frame.width+32, width: frame.width, height: 25)
    }
}

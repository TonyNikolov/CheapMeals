//
//  MealCell.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/27/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class MealCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dummyImage2")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Kiuftaci"
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "0.99 BGN"
        priceLabel.textColor = UIColor.white
        priceLabel.font = UIFont.systemFont(ofSize: 13)
        priceLabel.numberOfLines = 1
        return priceLabel
    }()
    
    func setupCell(){
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        imageView.frame = CGRect(x: 0, y: 0, width:100, height: 100)
        nameLabel.frame = CGRect(x: 0, y: frame.width+2, width: frame.width, height: 40)
        priceLabel.frame = CGRect(x: 0, y: frame.width+32, width: frame.width, height: 25)
    }
}

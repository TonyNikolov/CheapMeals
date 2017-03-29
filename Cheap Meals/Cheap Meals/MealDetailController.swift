//
//  MealDetailController.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/29/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class MealDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(MealDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.backgroundColor = UIColor.white
        
    }
    
    var meal: Meal? {
        didSet {
            navigationItem.title = meal?.name
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MealDetailHeader
        header.meal = meal
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
}

class MealDetailHeader: BaseCell {
    
    var meal: Meal? {
        didSet{
            if let imageName = meal?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            
            if let nameLb = meal?.name {
                nameLabel.text = nameLb
            }
            
            if let priceLb = meal?.price {
                priceLabel.text = String(describing: priceLb)
            } else {
                priceLabel.text = "Free"
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
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "price test"
        priceLabel.font = UIFont.systemFont(ofSize: 20)
        return priceLabel
        
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
        let sc = UISegmentedControl(items:["Details","Reviews"])
        sc.tintColor = UIColor.darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    override func setupCell() {
        super.setupCell()
        addSubview(segmentedControll)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-14-[v0(120)]-8-[v1]", views: imageView,nameLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0(120)]", views: imageView)
        addConstraintsWithFormat(format: "V:|-14-[v0(20)]", views: nameLabel)
        
        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentedControll)
        addConstraintsWithFormat(format: "V:[v0(34)]-8-|", views: segmentedControll)
        
        addConstraintsWithFormat(format: "H:[v0(120)]-30-|", views: priceLabel)
        addConstraintsWithFormat(format: "V:[v0(32)]-44-|", views: priceLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: dividerLineView)
        
        
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String:UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(){
        
    }
}

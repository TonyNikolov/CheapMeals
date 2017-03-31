//
//  BaseCell.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/30/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

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


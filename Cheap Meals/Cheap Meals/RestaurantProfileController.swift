//
//  RestaurantProfileController.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/29/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class RestaurantProfileController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 218, g: 80, b: 84)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action:#selector(onBackTapped))
    }
    
    func onBackTapped() {
        dismiss(animated: true, completion: nil )
    }
}

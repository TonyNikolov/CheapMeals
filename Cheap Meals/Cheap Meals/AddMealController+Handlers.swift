//
//  AddMealController+Handlers.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/28/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

extension AddMealController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func handleSelectMealImage(){
        if galleryCameraSegmentedControl.selectedSegmentIndex == 0 {
            handleGallery()
        } else{
            handleCamera()
        }
        
    }
    
    
    func handleCamera(){
        print("camera")
    }
    
    func handleGallery(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true, completion: nil)
        
    }
}

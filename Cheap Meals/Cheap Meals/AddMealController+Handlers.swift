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
    
    func handlePublishTapped(){
        let meal = constructMealObject()
        if validateMeal(meal: meal) {
            self.data?.delegate = self
            self.data?.pushMeal(meal: meal)
        }
    }
    
    private func validateMeal(meal: Meal) -> Bool{
        if meal.name.isNilOrEmpty {
            showToast(message: "Name field is empty")
            return false
        }
        if meal.image == nil {
            showToast(message: "Select image")
            return false
        }
        if meal.price.isNilOrEmpty {
            showToast(message: "Specify price")
            return false
        }
        if meal.weigth.isNilOrEmpty {
            showToast(message: "Specify weigth")
            return false
        }
        return true
    }
    
    private func constructMealObject() -> Meal{
        let meal = Meal()
        meal.name = nameTextField.text!
        meal.image = mealImageView.image!
        meal.price = priceTextField.text!
        meal.weigth = weigthTextField.text!
        return meal
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        } else{
            print("picking image went wrong")
        }
        
        if let selectedImage = selectedImageFromPicker {
            mealImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil )
    }
    
    func handleCamera(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        present(picker,animated: true, completion: nil)
        
    }
    
    func handleGallery(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
        picker.allowsEditing = true
        present(picker,animated: true, completion: nil)
        
    }
}

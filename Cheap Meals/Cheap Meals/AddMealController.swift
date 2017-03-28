//
//  AddMealController.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/28/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class AddMealController: UIViewController, UITextViewDelegate, DataDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 218, g: 80, b: 84)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action:#selector(onBackTapped))
        shortDescriptionTextField.delegate = self
        view.addSubview(inputContainerView)
        view.addSubview(publishMealButton)
        view.addSubview(galleryCameraSegmentedControl)
        view.addSubview(mealImageView)
        setupInputContainerView()
        setupPublishMealButton()
        setupGalleryCamereSegmentedControl()
        setupProfileImageView()

    }
    
    func onBackTapped() {
        dismiss(animated: true, completion: nil )
    }
    
    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let publishMealButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 219, g: 80, b: 84)
        button.setTitle("Publish now", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePublishTapped)))
        
        return button
    }()


    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let priceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Price in BGN"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let priceSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let weigthTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Weight in grams"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let shortDescriptionTextField: UITextView = {
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "Short description"
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.textColor = UIColor.lightGray
        return tf
    }()
    
    let galleryCameraSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Image from Gallery", "Image from Camera"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        return sc
    }()
    
    //needs to be lazy var so it can access "self"
    lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectMealImage)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    func handlePublishTapped(){
        
    }
    
    func collectInputData(){
        
    }
    
    func constructMealObject(){
        
    }
    
    func setupGalleryCamereSegmentedControl(){
        galleryCameraSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        galleryCameraSegmentedControl.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        galleryCameraSegmentedControl.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 1).isActive = true
        galleryCameraSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
     
    func setupPublishMealButton(){
        publishMealButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        publishMealButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive=true
        publishMealButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive=true
        publishMealButton.heightAnchor.constraint(equalToConstant: 50).isActive=true
        
    }
    
    var inputsContainerViewHeigthAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var priceTextFieldHeightAnchor: NSLayoutConstraint?
    var weigthTextFieldHeightAnchor: NSLayoutConstraint?
    var shortDescriptionTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupInputContainerView(){
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeigthAnchor = inputContainerView.heightAnchor.constraint(equalToConstant: 200)
        inputsContainerViewHeigthAnchor?.isActive = true
        
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeparator)
        inputContainerView.addSubview(priceTextField)
        inputContainerView.addSubview(priceSeparator)
        inputContainerView.addSubview(weigthTextField)
        inputContainerView.addSubview(shortDescriptionTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive=true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive=true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/4)
        nameTextFieldHeightAnchor?.isActive=true
        
        nameSeparator.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparator.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        priceTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        priceTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive=true
        priceTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 1/2).isActive=true
        priceTextFieldHeightAnchor = priceTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/4)
        priceTextFieldHeightAnchor?.isActive=true
        
        priceSeparator.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        priceSeparator.topAnchor.constraint(equalTo: priceTextField.bottomAnchor).isActive = true
        priceSeparator.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        priceSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        weigthTextField.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: 12).isActive = true
        weigthTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive=true
        weigthTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 1/2).isActive=true
        weigthTextFieldHeightAnchor = weigthTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/4)
        weigthTextFieldHeightAnchor?.isActive=true
        
        shortDescriptionTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        shortDescriptionTextField.topAnchor.constraint(equalTo: priceSeparator.bottomAnchor).isActive=true
        shortDescriptionTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive=true
        shortDescriptionTextFieldHeightAnchor = shortDescriptionTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 2/4)
        shortDescriptionTextFieldHeightAnchor?.isActive=true
        
        
    }

    func setupProfileImageView(){
        mealImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mealImageView.bottomAnchor.constraint(equalTo: galleryCameraSegmentedControl.topAnchor, constant: -12).isActive = true
        mealImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        mealImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView.text.isEmpty {
            textView.text = "Short description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
}

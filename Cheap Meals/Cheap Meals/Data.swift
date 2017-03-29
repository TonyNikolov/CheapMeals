//
//  File.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/26/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class Data: DataProtocol {
    
    var delegate: DataDelegate?
    
    func getRestaurants() {
        let ref = FIRDatabase.database().reference().child("restaurants")
        ref.observe(.value, with: { snapshot in
            print("get restaurants value \(snapshot.value!)")
        })
        
    }
    
    func userLogin(withEmail email: String, andPassword password: String){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil{
                print(error!)
            } else{
                weak var weakSelf = self
                weakSelf?.delegate?.onSuccessLogin()
            }
            
        })
        
    }
    
    func userLogout(){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    func userRegister(withEmail email: String, andPassword password: String, andDisplayName name: String, andProfileImage image: UIImage){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil{
                print(error!)
            }
            
            guard (user?.uid) != nil else {
                return
            }
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("\(imageName).png")
            if let uploadData = UIImagePNGRepresentation(image) {
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    if let imgeUrl = metadata?.downloadURL()?.absoluteString {
                    let values = ["name": name, "email": email, "profileImageUrl": imgeUrl]
                    weak var weakSelf = self
                    weakSelf?.registerUserIntoDb(uid: (user?.uid)!, values: values as [String : AnyObject])
                    }
                })
            }
            
            
        })
        
    }
    
    private func registerUserIntoDb(uid: String, values: [String: AnyObject]){
        let dbRef = FIRDatabase.database().reference().child("restaurants").child(uid)
        dbRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil{
                print(error!)
            } else{
                weak var weakSelf = self
                weakSelf?.delegate?.onSuccessRegister()
            }
        })
    }
    
    func userRegister(withEmail email: String, andPassword password: String, andDisplayName name: String){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil{
                print(error!)
            }
            
            guard (user?.uid) != nil else {
                return
            }
            let dbRef = FIRDatabase.database().reference().child("restaurants").child((user?.uid)!)
            let values = ["name": name, "email": email]
            dbRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil{
                    print(error!)
                } else{
                    weak var weakSelf = self
                    weakSelf?.delegate?.onSuccessRegister()
                }
            })
        })
        
    }
    
    func isUserLoggedIn() -> Bool {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            return false
        }
        
        return true
    }
    
}


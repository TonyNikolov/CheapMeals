//
//  File.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 3/26/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class Data: DataProtocol {
    
    var delegate: DataDelegate?
    
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
        
    }
    
    func userRegister(withEmail email: String, andPassword password: String, andDisplayName name: String){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil{
                print(error!)
            }
            
            guard (user?.uid) != nil else {
                return
            }
            
            let ref = FIRDatabase.database().reference().child("restaurants").child((user?.uid)!)
            let values = ["name": name, "email": email]
            ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil{
                    print(error!)
                } else{
                    weak var weakSelf = self
                    weakSelf?.delegate?.onSuccessRegister()
                }
            })
        })

    }
    
}


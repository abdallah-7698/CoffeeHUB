//
//  UserModel.swift
//  CoffeeHUB
//
//  Created by Abdallah on 24/11/2022.
//

import Foundation
import FirebaseAuth
import ProgressHUD

struct UserModel : Codable{
    
    let id : String
    let userName : String
    let email : String
    var orders : [String]
    
    static var currentID : String {
        return Auth.auth().currentUser!.uid
    }
    
}

func saveUserLocally( _ user : UserModel){
    let encoder = JSONEncoder()
    do{
        let data = try encoder.encode(user)
        UserDefaults.standard.set(data, forKey: kCURRENTUSER)
    }catch{ ProgressHUD.showError(error.localizedDescription)}
}

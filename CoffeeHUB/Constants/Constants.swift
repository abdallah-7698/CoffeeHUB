//
//  Constants.swift
//  CoffeeHUB
//
//  Created by Abdallah on 20/11/2022.
//

import UIKit

enum Colors {
    static let brown: UIColor        = UIColor(red:0.55, green:0.45, blue:0.42, alpha:1.0)
    static let coffee : UIColor      = UIColor(red: 0.722, green: 0.502, blue: 0.416, alpha: 1.0)
    static let darkCoffee : UIColor  = UIColor(red: 0.176, green: 0.078, blue: 0.051, alpha: 1.0)
    static let mediamCofee : UIColor = UIColor(red: 0.725, green: 0.533, blue: 0.459, alpha: 1.0)
    static let lightCoffee : UIColor = UIColor(red: 0.549, green: 0.455, blue: 0.416, alpha: 1.0)
    static let lightGray: UIColor    = UIColor(red:0.90, green:0.88, blue:0.87, alpha:1.0)
}

enum Title : String {
    case email          = "Email"
    case password       = "Password"
    case name           = "Name"
    case login          = "Log In"
    case register       = "Register"
    case total          = "Total:"
    case addToChart     = "Add to Cart"
    case forgetPass     = "Forgot password?"
    case createAccount  = "Don’t have an account?"
    case haveAccount    = "Already have account?"
}

enum pattern {
    static let namePattern      = "\\w{3,18}$"
    static let emailPattern     = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
    static let passwordPattern  = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
}

enum PatternValidate : String {
    case namePattern      = "^\\w{3,18}$"
    case emailPattern     = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
    case passwordPattern  = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
    var usedPattern  : NSPredicate{
        return NSPredicate(format: "SELF MATCHES %@",self.rawValue)
    }
}

// MARK:  Keys

public let kCURRENTUSER     = "currentUser"
public let kFILEREFERENCE   = "gs://rxswiftcoffeeapp-48348.appspot.com"
public let kISFIRSTTIME     = "isFirstTime"

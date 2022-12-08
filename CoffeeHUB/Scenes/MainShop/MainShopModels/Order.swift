//
//  Order.swift
//  CoffeeHUB
//
//  Created by Abdallah on 04/12/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Order : Codable{
    let id : String
    let coffee : Coffee
    let count : Int
    let size : String
    let sugarSpoons : Int
    @ServerTimestamp var createDate = Date()
}

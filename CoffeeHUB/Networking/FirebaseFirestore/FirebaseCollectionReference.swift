//
//  FirebaseCollectionReference.swift
//  CoffeeHUB
//
//  Created by Abdallah on 29/11/2022.
//

import Foundation
import Firebase

enum FCollectionReference : String {
    case User
    case Coffee
    case Order
}

func FirestoreReference(_ collectionReference : FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}


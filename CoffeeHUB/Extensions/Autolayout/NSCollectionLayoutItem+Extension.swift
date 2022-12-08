//
//  NSCollectionLayoutItem+Extension.swift
//  CoffeeHUB
//
//  Created by Abdallah on 21/11/2022.
//

import UIKit

extension NSCollectionLayoutItem {
    static func withEntireSize() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        return NSCollectionLayoutItem(layoutSize: itemSize)
    }
}



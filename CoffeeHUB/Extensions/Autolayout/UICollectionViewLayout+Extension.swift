//
//  UICollectionViewLayout+Extension.swift
//  CoffeeHUB
//
//  Created by Abdallah on 21/11/2022.
//

import UIKit

extension UICollectionViewLayout{
    
   static func createLayout() -> UICollectionViewCompositionalLayout{
        let item = NSCollectionLayoutItem.withEntireSize()
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.95))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}


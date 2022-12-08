//
//  OnBoardingCell.swift
//  CoffeeHUB
//
//  Created by Abdallah on 21/11/2022.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {
    
    static let reuseID = "OnBoardingCell"
    
    private let imageView : UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
     func configure(with image : UIImage){
         configureUI()
         imageView.image = image
    }
    
    private func configureUI(){
        contentView.backgroundColor = .clear
        contentView.addSubview(imageView)
        imageView.addConstarint(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 20, paddingLeading: 80, paddingTrainling: -80, paddingBottom: -90, height: nil, width: nil)
    }
}

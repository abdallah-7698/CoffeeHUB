//
//  ShopItemFirstView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 01/12/2022.
//

import UIKit

class ShopItemFirstView: UIView {
    
    let contaienrBackgroundImage = UIImageView()
    let coupImage = UIImageView()
    
    init(){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(contaienrBackgroundImage , coupImage)
        contaienrBackgroundImage.image = UIImage(named: "header")
        coupImage.image = UIImage(named: "coup")
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(imageStirngURL : String?){
        coupImage.setImage(imageStirngURL ?? "" , placeholderImage: UIImage(named: "coup")!)
    }
    
    private func setConstrains(){
        contaienrBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contaienrBackgroundImage.topAnchor.constraint(equalTo: topAnchor),
            contaienrBackgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            contaienrBackgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            contaienrBackgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        coupImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coupImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            coupImage.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}

//
//  MenuTVCell.swift
//  CoffeeHUB
//
//  Created by Abdallah on 29/11/2022.
//

import UIKit

class MenuTVCell: UITableViewCell {

    static let reuseId = "MenuTVCell"
    
    let coffeeImage = UIImageView()
    let coffeeNameLable = CFCoffeeNameLable()
    

    //MARK: - UI Configuration
    private func configureUI(){
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(coffeeImage)
        coffeeImage.contentMode = .scaleAspectFit
        coffeeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        coffeeImage.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 15),
        coffeeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        coffeeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -15),
        coffeeImage.heightAnchor.constraint(equalToConstant: 90),
        coffeeImage.widthAnchor.constraint(equalToConstant: 75)
        ])
        contentView.addSubview(coffeeNameLable)
        NSLayoutConstraint.activate([
        coffeeNameLable.leadingAnchor.constraint(equalTo: coffeeImage.trailingAnchor, constant: 30),
        coffeeNameLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        coffeeNameLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    //MARK: - HelperFunctions
    
    func configure(coffee : Coffee){
        configureUI()
        coffeeImage.setImage(coffee.iconLink ?? "", placeholderImage: UIImage(named: "coup")!)
        coffeeNameLable.text = coffee.name
    }
    
    
    
}

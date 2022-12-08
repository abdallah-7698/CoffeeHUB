//
//  ChartCell.swift
//  CoffeeHUB
//
//  Created by Abdallah on 06/12/2022.
//

import UIKit


class ChartCell: UITableViewCell {
    
    let coffeeImage = UIImageView()
    let coffeeNameLable = CFCoffeeNameLable()
    let countOfCoups = CFCoffeeNameSublableLable(title: "0 cup of coffee", fontSize: 17)
    let coupSize = CFCoffeeNameSublableLable(title: "Small", fontSize: 17)
    let sugarSpoons = CFCoffeeNameSublableLable(title: "1 Sugar Spoons", fontSize: 17)
    let totalPriceLable = CFCoffeeNameSublableLable(title: "£ 0", fontSize: 17)
    
    static let reuseId = "ChartCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureUI()
    }
    
    private func configureUI(){
        self.selectionStyle = .none
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
            coffeeNameLable.leadingAnchor.constraint(equalTo: coffeeImage.trailingAnchor, constant: 15),
            coffeeNameLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            coffeeNameLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor , constant: -20)
        ])
        
        contentView.addSubview(countOfCoups)
        NSLayoutConstraint.activate([
            countOfCoups.topAnchor.constraint(equalTo: coffeeNameLable.bottomAnchor, constant: 5),
            countOfCoups.leadingAnchor.constraint(equalTo: coffeeNameLable.leadingAnchor)
        ])
        
        contentView.addSubview(coupSize)
        NSLayoutConstraint.activate([
            coupSize.topAnchor.constraint(equalTo: countOfCoups.bottomAnchor, constant: 5),
            coupSize.leadingAnchor.constraint(equalTo: coffeeNameLable.leadingAnchor)
        ])
        
        contentView.addSubview(sugarSpoons)
        NSLayoutConstraint.activate([
            sugarSpoons.topAnchor.constraint(equalTo: countOfCoups.bottomAnchor, constant: 5),
            sugarSpoons.leadingAnchor.constraint(equalTo: coupSize.trailingAnchor , constant: 15)
        ])
        
        contentView.addSubview(totalPriceLable)
        totalPriceLable.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        NSLayoutConstraint.activate([
            totalPriceLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            totalPriceLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    func configureCells(order : Order){
        coffeeImage.setImage(order.coffee.iconLink!, placeholderImage: UIImage(named: "coup")!)
        coffeeNameLable.text = order.coffee.name
        countOfCoups.text = "\(order.count) cup of coffee"
        coupSize.text = order.size
        sugarSpoons.text = "\(order.sugarSpoons) Sugar Spoons"
        let addedPrice : Float = order.size == "big" ? 1.0 : 0.0
        totalPriceLable.text = "£ \(order.coffee.price * Float(order.count) + order.coffee.price * Float(order.count) * addedPrice * 0.3 )"
    }
    
}

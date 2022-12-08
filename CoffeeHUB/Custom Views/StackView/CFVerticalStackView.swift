//
//  CFVerticalStackView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 21/11/2022.
//

import UIKit

class CFVerticalStackView: UIStackView {

    override init(frame: CGRect){
        super.init(frame: frame)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        axis         = .vertical
        distribution = .fillEqually
    }
    
     func addArrangedSubviews(_ views: UIView...) {
         views.forEach{self.addArrangedSubview($0)}
    }
    
}

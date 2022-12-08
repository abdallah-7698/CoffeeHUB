//
//  CFPageController.swift
//  CoffeeHUB
//
//  Created by Abdallah on 22/11/2022.
//

import UIKit

class CFPageController: UIPageControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        numberOfPages                   = 3
        currentPageIndicatorTintColor   = Colors.mediamCofee
        pageIndicatorTintColor          = Colors.mediamCofee.withAlphaComponent(0.2)
        isUserInteractionEnabled        = false
        translatesAutoresizingMaskIntoConstraints = false
    }
}

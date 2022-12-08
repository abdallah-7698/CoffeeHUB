//
//  CFClearButton.swift
//  CoffeeHUB
//
//  Created by Abdallah on 21/11/2022.
//

import UIKit

class CFClearButton: UIButton {
   
    override init(frame: CGRect){
        super.init(frame: frame)
        configue()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(contentText : Title){
        self.init(type: .system)
        self.setTitle(contentText.rawValue, for: .normal)
        titleLabel!.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private func configue(){
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(Colors.mediamCofee, for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 10
    }


}

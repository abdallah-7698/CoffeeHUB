//
//  CFButton.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 30/06/2022.
//

import UIKit

class CFMainButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title : Title){
        self.init(type: .system)
        setTitle(title.rawValue, for: .normal)
    }
    convenience init(systemImageName : String , size : CGFloat){
        self.init(type: .system)
        
        let image = UIImage(systemName: systemImageName , withConfiguration: UIImage.SymbolConfiguration(font : .systemFont(ofSize: size)))!
        setImage(image, for: .normal)
        tintColor = .white
    }
    
    func configure(){
        isUserInteractionEnabled = true
        setTitleColor(.white, for: .normal)
        backgroundColor                                 = Colors.coffee
        layer.cornerRadius                              = 66 / 2
        titleLabel!.font                                = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints       = false
    }
    
}

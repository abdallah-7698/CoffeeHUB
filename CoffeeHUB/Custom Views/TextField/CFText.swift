//
//  CFText.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 30/06/2022.
//

import UIKit

class CFText: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder : Title){
        super.init(frame: .zero)
        configure()
        self.placeholder = placeholder.rawValue
        if placeholder == .password{
            isSecureTextEntry = true
        }
    }
    
    func configure(){
        borderStyle                               = .none
       // translatesAutoresizingMaskIntoConstraints = false
        font                                      = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth                 = true
        minimumFontSize                           = 17
        autocorrectionType                        = .no
        backgroundColor                           = .tertiarySystemBackground
        textColor                                 = .label
        tintColor                                 = .label
        autocapitalizationType                    = .none
    }
    
}

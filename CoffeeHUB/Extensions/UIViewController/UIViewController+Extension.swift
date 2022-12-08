//
//  UIViewController+Extension.swift
//  CoffeeHUB
//
//  Created by Abdallah on 23/11/2022.
//

import UIKit
import RxSwift


extension UIViewController{
    func addBackArrow(onDispose: inout DisposeBag){
        navigationItem.hidesBackButton = true
        let barBackButtobItem = UIBarButtonItem()
        barBackButtobItem.image = UIImage(systemName: "chevron.backward")
        barBackButtobItem.tintColor = Colors.mediamCofee
        navigationItem.leftBarButtonItem = barBackButtobItem
        barBackButtobItem.rx.tap.subscribe(onNext: {
            self.navigationController?.popViewController(animated: true)}).disposed(by: onDispose)
    }
}

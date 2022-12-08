//
//  UIView+Extension.swift
//  CoffeeHUB
//
//  Created by Abdallah on 20/11/2022.
//

import UIKit

extension UIView{
    
    func addSubviews(_ views : UIView... ){
        views.forEach { addSubview($0) }
    }
    
    func TapToEndEditing(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK:  Handel Constrains
    
    func setToEdge(of superView : UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
    func addConstrain(top : NSLayoutYAxisAnchor , leading : NSLayoutXAxisAnchor , trailing : NSLayoutXAxisAnchor ,paddingTop: CGFloat = 0, paddingLeading: CGFloat = 0, paddingTrainling: CGFloat = 0 , height : CGFloat  ){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: top, constant: paddingTop),
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading),
            trailingAnchor.constraint(equalTo: trailing, constant: paddingTrainling),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func addConstarint(top: NSLayoutYAxisAnchor, leading : NSLayoutXAxisAnchor , trailing : NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, paddingTop: CGFloat = 0, paddingLeading: CGFloat = 0, paddingTrainling: CGFloat = 0, paddingBottom: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: top, constant: paddingTop),
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading),
            trailingAnchor.constraint(equalTo: trailing, constant: paddingTrainling),
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom)
        ])
    }
    
    func addConstarint(top: NSLayoutYAxisAnchor?, leading : NSLayoutXAxisAnchor? , trailing : NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, paddingTop : CGFloat = 0, paddingLeading: CGFloat = 0, paddingTrainling: CGFloat = 0, paddingBottom: CGFloat = 0 , height: CGFloat? , width : CGFloat?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
             topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
           }
        if let leading = leading {
              leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
            }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: paddingTrainling).isActive = true
          }
        if let bottom = bottom {
             bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
           }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
}

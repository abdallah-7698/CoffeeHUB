//
//  StartView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 29/11/2022.
//

import UIKit

protocol StartViewProtocol : AnyObject{
        
    func setOnBoardingData(collectionView : UICollectionView , pageController : UIPageControl , loginButton : UIButton , registerButton : UIButton)
}

class StartView: UIView {

    //MARK: - IBOutlet
    
    private var collectionView : UICollectionView!
    private var imageView   = UIImageView()
    let pageController      = CFPageController()
    let startingLable       = CFBasicLable(title: "Get the best coffee in town!", fontSize: 37, color: Colors.mediamCofee)
    let registerButton      = CFMainButton(title: .register)
    let loginButton         = CFMainButton(title: .login)
  
    weak var delegate : StartViewProtocol?
    
    init(delegate : StartViewProtocol){
        super.init(frame: .zero)
        self.delegate = delegate
        configureUI()
        setConstrains()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  Cofiguration func
    
    private func configureUI(){
        backgroundColor = .systemBackground
        imageView.image = UIImage(named: "onBoardingPG")
        imageView.contentMode = .scaleAspectFill
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: .createLayout())
        addSubviews(collectionView , pageController , startingLable , registerButton , loginButton)
        collectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseID)
        collectionView.addSubview(imageView)
        startingLable.textAlignment = .center
    }
    
    private func setConstrains(){
        collectionView.addConstarint(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, height: 450, width: nil)
        imageView.addConstarint(top: collectionView.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: collectionView.bottomAnchor,paddingTop: 25, height: nil, width: nil)
        pageController.addConstarint(top: collectionView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil,paddingTop: -30, paddingLeading: 145, paddingTrainling: -145, height:30, width: nil)
        startingLable.addConstarint(top: collectionView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil,paddingTop: 20 , paddingLeading: 30, paddingTrainling: -30, height: nil, width: nil)
        registerButton.addConstrain(top: startingLable.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 120, paddingLeading: 30, paddingTrainling: -30, height: 66)
        loginButton.addConstrain(top: registerButton.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 30, paddingTrainling: -30, height: 66)
    }
    
    private func configureCollectionView(){
        
        delegate?.setOnBoardingData(collectionView: collectionView, pageController: pageController, loginButton: loginButton, registerButton: registerButton)
    }
    

}

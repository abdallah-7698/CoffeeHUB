//
//  StartVC.swift
//  CoffeeHUB
//
//  Created by Abdallah on 21/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

class StartVC: UIViewController {
    
    
    //MARK: - Variables
    
    let bag = DisposeBag()
    let viewModel : StartViewModelProtocol  = StartViewModel()
    
    //MARK: -  View Life Cicle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func loadView() {
        super.loadView()
        let mainView = StartView(delegate: self)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.executeInTime()
    }
    
    
}


extension StartVC : StartViewProtocol{
    
    func setOnBoardingData(collectionView: UICollectionView, pageController: UIPageControl, loginButton: UIButton, registerButton: UIButton) {
        
        bindUI()
        changeIndex()
        addRegisterAction()
        addLoginAction()
        
        
        
        func bindUI(){
            viewModel.imagesObservable.bind(to: collectionView.rx.items(cellIdentifier: OnBoardingCell.reuseID, cellType: OnBoardingCell.self)){ row , value , cell in
                cell.configure(with: value)
            }.disposed(by: bag)
            
            viewModel.visiableCellRowIndex.bind(to: pageController.rx.currentPage).disposed(by: bag)
        }
        
        // MARK:  Change the Cell
        
        func changeIndex(){
            viewModel.visiableCellRowIndex.subscribe(onNext: { row in
                collectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredHorizontally, animated: true)
            }).disposed(by: bag)
        }
        
        // MARK: Buttons Action
        
        func addRegisterAction(){
            registerButton.rx.tap.subscribe {[weak self] (_) in
                guard let self = self else {return}
                let vc = SignupVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: bag)
        }
        
        func addLoginAction(){
            loginButton.rx.tap.subscribe {[weak self] (_) in
                guard let self = self else {return}
                let vc = LoginVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: bag)
        }
        
    }
    
}

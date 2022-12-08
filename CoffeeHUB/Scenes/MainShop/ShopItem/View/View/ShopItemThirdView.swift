//
//  ShopItemThirdView.swift
//  CoffeeHUB
//
//  Created by Abdallah on 02/12/2022.
//

import UIKit
import RxSwift
import SwiftUI

class ShopItemThirdView: UIView {
    
    //MARK: - IBOutlet
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var smallCoup: UIButton!
    @IBOutlet weak var bigCoup: UIButton!
    
    @IBOutlet weak var sugar0: UIButton!
    @IBOutlet weak var sugar1: UIButton!
    @IBOutlet weak var sugar2: UIButton!
    @IBOutlet weak var sugar3: UIButton!
    
    //MARK: - Variables
    
    var viewModel : ShopItemViewModelProtocol!
    var bag = DisposeBag()
    
    init(viewModel : ShopItemViewModelProtocol){
        super.init(frame: .zero)
        self.viewModel = viewModel
        configureUI()
        coupSizeAction()
        sugarNumberAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        loadNibFile()
        smallCoup.setImage(UIImage(named: "Group 19"), for: .normal)
        sugar1.alpha = 1
    }
    
    private func loadNibFile(){
        translatesAutoresizingMaskIntoConstraints = false
        Bundle.main.loadNibNamed(String(describing: ShopItemThirdView.self), owner: self,options: nil)
        containerView.frame = frame
        addSubview(containerView)
    }
    
    // MARK:  Action
    
    private func deselectCoupButtons(){
        smallCoup.setImage(UIImage(named: "Fill 7"), for: .normal)
        bigCoup.setImage(UIImage(named: "Fill 78"), for: .normal)
    }
    
    private func coupSizeAction(){
        // get
        smallCoup.rx.tap.subscribe {[weak self] _ in
            guard let self = self else {return}
            self.viewModel.coupSelectedBehavior.accept(CoupSizes.small.rawValue)
            self.deselectCoupButtons()
            self.smallCoup.setImage(UIImage(named: "Group 19"), for: .normal)
        }.disposed(by: bag)
        
        bigCoup.rx.tap.subscribe {[weak self] _ in
            guard let self = self else {return}
            self.viewModel.coupSelectedBehavior.accept(CoupSizes.big.rawValue)
            self.deselectCoupButtons()
            self.bigCoup.setImage(UIImage(named: "Group 20"), for: .normal)
        }.disposed(by: bag)
        //set
        viewModel.coupSelectedBehavior.subscribe(onNext: {[weak self] stringSize in
            guard let self = self else {return}
            switch stringSize{
            case "small":
                self.deselectCoupButtons()
                self.smallCoup.setImage(UIImage(named: "Group 19"), for: .normal)
            case "big":
                self.deselectCoupButtons()
                self.bigCoup.setImage(UIImage(named: "Group 20"), for: .normal)
            default:
                break
            }
        }).disposed(by: bag)
    }
    
    private func deselectSugerButtons(){
        sugar0.alpha = 0.2
        sugar1.alpha = 0.2
        sugar2.alpha = 0.2
        sugar3.alpha = 0.2
    }
    
    private func sugarNumberAction(){
        let sugarButtons = [sugar0 , sugar1 , sugar2 , sugar3]
        //set
        for value in  0...3{
            sugarButtons[value]!.rx.tap.subscribe {[weak self] (_) in
                guard let self = self else {return}
                self.viewModel.sugarSelectedBehavoir.accept(value)
                self.deselectSugerButtons()
                sugarButtons[value]!.alpha = 1
            }.disposed(by: bag)
        }
        //get
        viewModel.sugarSelectedBehavoir.subscribe(onNext: { sugarNumber in
            switch sugarNumber {
            case 0...3:
                self.deselectSugerButtons()
                sugarButtons[sugarNumber]!.alpha = 1
            default:
                break
            }
        }).disposed(by: bag)
        
    }
    
    
}

//
//  ViewModelBindableType.swift
//  RxNetflixClone
//
//  Created by DaeSeong Kim on 2022/02/20.
//

import UIKit


protocol ViewModelBindableType {
    associatedtype ViewModelType
    
    var viewModel : ViewModelType! {get set}
    func bind()
}

extension ViewModelBindableType where Self : UIViewController {
    mutating func bindViewModel(_ viewModel : Self.ViewModelType){
        self.viewModel = viewModel
        
        loadViewIfNeeded()  // 뷰컨트롤러를 뷰에 로드하기위해.
        
        bind()
    }
}



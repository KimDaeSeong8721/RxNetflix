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
        
        loadViewIfNeeded()  // ViewController의 view가 아직 로드되지 않은 경우 로드함.
        bind()
    }
}



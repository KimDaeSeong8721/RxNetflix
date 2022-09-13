//
//  ViewModelType.swift
//  RxTableExample
//
//  Created by DaeSeong on 2022/08/21.
//

import Foundation

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
   // var disposeBag: DisposeBag { get set }

    func transform(input: Input) -> Output
}

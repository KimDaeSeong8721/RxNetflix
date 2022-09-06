//
//  ViewModelType.swift
//  RxTableExample
//
//  Created by DaeSeong on 2022/08/21.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

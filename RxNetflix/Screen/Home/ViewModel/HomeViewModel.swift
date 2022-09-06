//
//  HomeViewModel.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/06.
//

import Foundation

import RxCocoa
import RxSwift
class HomeViewModel {
    //    private var titles : [Title] = [Title]()
    // private
    let disposeBag = DisposeBag()
    var imageUrlCol:[String] = ["https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg",
                       "https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg",
                       "https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg"
    ]
    var imageObservable: Observable<[[String]]> {
       
        return Observable<[[String]]>.of([imageUrlCol])
    }
   
}

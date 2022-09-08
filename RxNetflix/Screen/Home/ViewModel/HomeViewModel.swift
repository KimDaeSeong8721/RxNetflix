//
//  HomeViewModel.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/06.
//

import Foundation

import RxCocoa
import RxSwift
class HomeViewModel : ViewModelType {
    
    struct Input {
        
    }
    struct Output {
        
    }
    
    func transform(input: Input) -> Output{
        return Output()
    }
    var disposeBag = DisposeBag()
    var imageUrlCol:[String] = ["https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg",
                       "https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg",
                       "https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg"
    ]
    var titleObservable: BehaviorRelay<[[Title]]> = BehaviorRelay<[[Title]]>(value: [])
   

    func getTrendingMovies() {
        MovieAPI().getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titleObservable.accept([titles])
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
}

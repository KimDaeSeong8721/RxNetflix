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
    
    // MARK: - Properties
    
    private let replyTitlePreview = BehaviorRelay<TitlePreviewViewModel>(value: TitlePreviewViewModel(title: "", youtubeView: VideoElement(id: IdVideoElement(kind: "", videoId: "")), titleOverview: ""))
//    private let tapCollectionViewCell = PublishRelay<Title>()
    var disposeBag = DisposeBag()
    var imageUrlCol:[String] = ["https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg",
                       "https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg",
                       "https://www.theguru.co.kr/data/photos/20210937/art_16316071303022_bf8378.jpg"
    ]
    var titleObservable: BehaviorRelay<[[Title]]> = BehaviorRelay<[[Title]]>(value: [])
   
   
    // MARK: - Func
    
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

    // MARK: - Extension

extension HomeViewModel {
    
    struct Input {
        let tapCollectionViewCell: Observable<Title>
    }
    struct Output {
        let replyTitlePreview: Observable<TitlePreviewViewModel>
    }
    
    func transform(input: Input) -> Output {
        input.tapCollectionViewCell
        .subscribe { title in
                guard let titleOverview = title.element?.overview else { return}
                guard let titleName =
                        title.element?.originalTitle ?? title.element?.originalName else {
                    return
                }
                MovieAPI().getMovie(with: titleName + " trailer") { result in
                    switch result {
                    case .success(let videoElement) :
                        let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
                       
                        self.replyTitlePreview.accept(viewModel)
           //            print("1이다")
                    case .failure(let error) :
                        print(error.localizedDescription)
                    }
                }
              
            }.disposed(by: disposeBag)
        
     //   print("2이다")
        return Output(replyTitlePreview:replyTitlePreview.asObservable())
    }
}

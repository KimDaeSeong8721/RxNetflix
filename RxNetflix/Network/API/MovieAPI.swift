//
//  MovieAPI.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/07.
//

import Moya
import RxSwift
import NSObject_Rx
protocol MovieAPIType {
    func getTrendingMovies(completion : @escaping (Result<[Title],Error>) -> Void)
//    func getTrendingTvs(completion : @escaping (Result<[Title],Error>) -> Void)
//    func getUpcomingMovies(completion : @escaping (Result<[Title],Error>) -> Void)
//    func getPopular(completion : @escaping (Result<[Title],Error>) -> Void)
//    func getTopRated(completion : @escaping (Result<[Title],Error>) -> Void)
    func getMovie(with query : String, completion : @escaping (Result<VideoElement,Error>) -> Void)
}

final class MovieAPI : MovieAPIType, HasDisposeBag {

    
    private let provider = MoyaProvider<MovieService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var trendingMoviesResponse: TrendingTitleResponse?
    private var trendingTvsResponse: TrendingTitleResponse?
    private var popularResponse: TrendingTitleResponse?
    private var topRatedResponse: TrendingTitleResponse?
    private var getMovieResponse: YoutubeSearchResponse?
    
        
//    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
//        <#code#>
//    }
//
//    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
//        <#code#>
//    }
//
//    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
//        <#code#>
//    }
//
//    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
//        <#code#>
//    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        provider.rx.request(.getMovie(query: query), callbackQueue: .global()).subscribe { event in
            switch event {
            case let .success(data): // case .success(let data)랑 동일.
                do {
                    self.getMovieResponse = try data.map(YoutubeSearchResponse.self)
                    dump(self.getMovieResponse?.items[0])
                    completion(.success((self.getMovieResponse?.items[0])!))
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case let .failure(err):
                completion(.failure(err))
            }
        }
    }
}

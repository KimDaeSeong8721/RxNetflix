//
//  MovieService.swift
//  RxNetflix
//
//  Created by DaeSeong on 2022/09/07.
//

import Moya

enum MovieService {
    case trendingMovies
    case trendingTvs
    case upcomingMovies
    case popular
    case topRated
    case getMovie(query: String)
}

extension MovieService: TargetType {
    public var baseURL: URL {
        switch self {
        case .getMovie:
            return URL(string: GeneralAPI.youtubeBaseURL)!
        default:
            return URL(string: GeneralAPI.baseURL)!
        }
    }
    
    var path: String {
        switch self {
        case .trendingMovies:
            return "/3/trending/movie/day"
        case .trendingTvs:
            return "/3/trending/tv/day"
        case .upcomingMovies:
            return "/3/movie/upcoming?api_key=\(GeneralAPI.apiKey)&language=en-US&page=1"
        case .popular:
            return "/3/movie/popular?api_key=\(GeneralAPI.apiKey)&language=en-US&page=1"
        case .topRated:
            return "/3/movie/top_rated?api_key=\(GeneralAPI.apiKey)&language=en-US&page=1"
        case .getMovie(_):
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .getMovie(let query):
            return .requestParameters(parameters: ["q": query, "key": GeneralAPI.youtubeAPIKey], encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: ["api_key" : GeneralAPI.apiKey], encoding: URLEncoding.default)  // ?
        }
       
        }
    

    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}


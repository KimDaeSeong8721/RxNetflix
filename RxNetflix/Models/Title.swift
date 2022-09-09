//
//  Movie.swift
//  NetflixClone
//
//  Created by DaeSeong Kim on 2022/02/17.
//

import Foundation

struct TrendingTitleResponse : Codable {
    let results : [Title]
}



// api와 키가 똑같아야함 틀리면 에러발생함.
struct Title : Codable {
    let id : Int
    let mediaType : String?
    let originalName : String?
    let originalTitle : String?
    let posterPath : String?
    let overview : String?
    let voteCount : Int?
    let releaseDate : String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}


/*
 
 
 id = 634649;
 "media_type" = movie;
 "original_language" = en;
 "original_title" = "Spider-Man: No Way Home";
 overview = "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.";
 popularity = "7700.02";
 "poster_path" = "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg";
 "release_date" = "2021-12-15";
 title = "Spider-Man: No Way Home";
 video = 0;
 "vote_average" = "8.4";
 "vote_count" = 7867;
 */

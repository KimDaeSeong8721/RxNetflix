//
//  YoutubueSearchResponse.swift
//  NetflixClone
//
//  Created by DaeSeong Kim on 2022/02/19.
//

import Foundation




struct YoutubeSearchResponse  : Codable{
    let items: [VideoElement]
}

struct VideoElement : Codable {
    let id : IdVideoElement
    }

struct IdVideoElement : Codable {
    let kind : String
    let videoId : String
}

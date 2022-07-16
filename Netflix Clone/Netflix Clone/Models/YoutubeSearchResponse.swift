//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by eunji on 2022/07/16.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}

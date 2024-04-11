//
//  Music.swift
//  DailyMue
//
//  Created by eunseou on 4/11/24.
//

import Foundation

struct Music: Decodable {
    let results: [MusicInfo]
}

struct MusicInfo: Decodable {
    let artistId: Int
    let trackId: Int
    let collectionId: Int?
    let artistName: String
    let trackName: String
    let collectionName: String?
    let artworkUrl100: String
}

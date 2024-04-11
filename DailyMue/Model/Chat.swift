//
//  Chat.swift
//  DailyMue
//
//  Created by eunseou on 4/11/24.
//

import Foundation

struct Chat: Decodable {
    let candidates: [Candidate]
}

struct Candidate: Decodable {
    let content: Content
}

struct Content: Decodable {
    let parts: [Part]
}

struct Part: Decodable {
    let text: String
}

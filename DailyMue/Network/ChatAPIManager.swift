//
//  ChatAPI.swift
//  Muiliy
//
//  Created by eunseou on 4/8/24.
//

import Foundation
import Alamofire

class ChatAPIManager {
    
    // 싱글톤 패턴
    static let shared = ChatAPIManager()
    
    private init() { }
    
    func callRequest(text: String, completionHandler: @escaping (Chat) -> Void){
        
        let url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(APIKey.geminiKey)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        let parameters: [String: Any] = [
            "contents": [
                "parts": [
                    ["text": text]
                ]
            ]
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).responseDecodable(of: Chat.self){ response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
}

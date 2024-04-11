//
//  iTunesSearchAPI.swift
//  Muiliy
//
//  Created by eunseou on 4/5/24.
//

import Foundation
import RxSwift
import RxCocoa

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}


class iTunesSearchAPIManager {
    
    static let shared = iTunesSearchAPIManager()
    
 
    static func fetchiTunesMusicList(query: String) -> Observable<Music> {
        
        return Observable<Music>.create { observer in
            
            guard let url = URL(string: "https://itunes.apple.com/search?term=\(query)&country=kr&media=music") else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("DataTask Succeed")
                
                if let _ = error {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    print("Response Error")
                    observer.onError(APIError.statusError)
                    return
                }
                
                if let data = data,
                   let appData = try? JSONDecoder().decode(Music.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted()
                } else {
                    print("응답은 왔으나 디코딩 실패")
                    observer.onError(APIError.unknownResponse)
                }
            }.resume()
            return Disposables.create()
        }.debug()
    }
    
    static func fetchiTunesMusicDetail(query: String) -> Observable<Music> {
        
        return Observable<Music>.create { observer in
            
            guard let url = URL(string: " https://itunes.apple.com/lookup?id=\(query)") else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("DataTask Succeed")
                
                if let _ = error {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    print("Response Error")
                    observer.onError(APIError.statusError)
                    return
                }
                
                if let data = data,
                   let appData = try? JSONDecoder().decode(Music.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted() // fetchBoxOfficeData가 계속 쌓이므로 -> Transform은 살아있지만, fetchBoxOfficeData는 종료시키기.
                } else {
                    print("응답은 왔으나 디코딩 실패")
                    observer.onError(APIError.unknownResponse)
                }
            }.resume()
            return Disposables.create()
        }.debug()
    }
}

//
//  SessionManager.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxSwift

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class SessionManager {
    static func responseData(for url: URL, method: HTTPMethod = .get) -> Observable<Data> {
        return Observable.create({ (observer) -> Disposable in
            let session = URLSession.shared

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue

            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                } else if let responseData = data {
                    observer.onNext(responseData)
                    observer.onCompleted()
                }
            })
            
            task.resume()
            
            
            
            return Disposables.create()
        })
    }
    
    static func responseProducts(for url: URL, method: HTTPMethod = .get) -> Observable<[Product]> {
        return responseData(for: url, method: method)
            .map({ (data) -> [Product] in
                let parser = ProductXMLParser()
                let products = parser.products(for: data)
                
                return products
            })
    }
}

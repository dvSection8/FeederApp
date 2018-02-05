//
//  FeedRepository.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxSwift

protocol IFeedRepository {
    func fetchProducts() -> Observable<[Product]>
}

class FeedRepository: IFeedRepository {
    var urls: [String] = []
    
    func fetchProducts() -> Observable<[Product]> {
        
        var responseObservables: [Observable<[Product]>] = []
        
        urls.forEach { (url) in
            guard let url = URL.init(string: url) else {
                return
            }

            responseObservables.append(SessionManager.responseProducts(for: url))
        }
        
        return Observable.zip(responseObservables) { productsArr in
            var productsAggregate: [Product] = []
            productsArr.forEach({ (products) in
                productsAggregate.append(contentsOf: products)
            })
        
            return productsAggregate
        }
    }
}

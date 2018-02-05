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
        
//        urls.foreac
        guard let url = URL.init(string: "http://www.amazon.co.uk/gp/rss/bestsellers/books/72/ref=zg_bs_72_rsslink") else {
            return Observable.empty()
        }
        
        return SessionManager.responseProducts(for: url)
    }
}

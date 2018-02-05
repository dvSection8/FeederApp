//
//  ProductViewModel.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct ProductViewModel {
    var title: String {
        return product.title
    }

    var imageUrl: URL? {
        return URL(string: product.imageUrl)
    }
    
    var rating: String {
        if product.rating > 0 {
            return "Ratings: \(product.rating) of 5.0"
        } else {
            return "Ratings: No Ratings Yet."
        }
        
    }
    
    var pubDate: String {
        return "Publication Date: \(product.pubDate)"
    }
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
}

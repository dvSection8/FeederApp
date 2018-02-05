//
//  Product.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct Product: Codable {
    var title: String = ""
    var guid: String?
    var pubDate: String = ""
    var link: String = ""
    var imageUrl: String = ""
    var rating: Double = 0
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.guid == rhs.guid
    }
}



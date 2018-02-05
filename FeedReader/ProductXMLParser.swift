//
//  ProductXMLParser.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import SwiftSoup

class Tag {
    var name = "";
    var count: Int?;
}

class ProductXMLParser: NSObject, XMLParserDelegate {
    private struct ProductKeys {
        static var parentTag = "item"
        static var titleTag = "title"
        static var pubDateTag = "pubDate"
        static var descTag = "description"
        static var guidTag = "guid"
        
        // NOTE: Image url and rating are retrieved from description because they dont have their own 
        // tag
    }

    private static var xmlDateFormatter: DateFormatter = {
        let dm = DateFormatter()
        dm.dateFormat = "EEE, d MMM yyyy HH:mm:ss zzz"
        
        return dm 
    }()
    
    private static var productDateFormatter: DateFormatter = {
        let dm = DateFormatter()
        dm.dateFormat = "EEE, d MMM yyyy"
        
        return dm 
    }()
    
    private var products: [Product] = []
    
    var elementName: String = "'"
    var title: String = ""
    var pubDate: String = ""
    var imageUrl: String = ""
    var rating: Double = 0
    var desc: String = ""
    var guid: String = ""
    
    func products(for xmlData: Data) -> [Product] {
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        let isSuccessful = parser.parse()
        
        if !isSuccessful {
            return []
        } else {
            return products
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == ProductKeys.parentTag {
            var product = Product()
            product.title = title
            product.pubDate = pubDate
            product.imageUrl = imageUrl
            product.rating = rating
            product.guid = guid
            
            products.append(product)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        guard !data.isEmpty else {
            return
        }
        
        switch elementName {
        case ProductKeys.titleTag:
            title = string
        case ProductKeys.pubDateTag:
            pubDate = formattedDate(for: string) ?? ""
        case ProductKeys.guidTag:
            guid = extractedGUID(from: string)
        case ProductKeys.descTag:
            desc = string
            
            if let document = try? SwiftSoup.parseBodyFragment(desc) {
                let titleArr = try? document.select("a")
                            .array()
                if let arr = titleArr, arr.count > 2 {
                    if let prodTitle = (try? arr[1].text()) ?? nil{
                        self.title = prodTitle
                    }
                }
                
                
                // Get the html node for the image url
                // I just assume that image url will be on the first img tag
                let url = try? document.select("a")
                            .first()?
                            .children()
                            .first()?
                            .attr("src")
                
                if let img = url ?? nil {
                    imageUrl = img
                }
                
                
                // Same as the rating
                // Assuming that the rating always come in last
                let ratingImgUrl = try? document.select("img")
                                    .last()?
                                    .attr("src")
                
                if let _ratingImgUrl = ratingImgUrl ?? nil, let rating = extractedRating(from: _ratingImgUrl) {
                    self.rating = rating
                }
            }
        default:
            break
        }
    }
    
    private func formattedDate(for dateString: String) -> String? {
        guard let date = ProductXMLParser.xmlDateFormatter.date(from: dateString) else {
            return nil
        }
        
        return ProductXMLParser.productDateFormatter.string(from: date)
    }
    
    private func extractedRating(from imageUrl: String) -> Double? {
        // Sample format for the url on which rating will be extracted
        // https://images-eu.ssl-images-amazon.com/images/G/02/detail/stars-4-5._CB192253866_.gif
        let components = imageUrl.components(separatedBy: "/")
        
        guard !components.isEmpty else { return nil }
        
        guard let ratingStr = components[components.count - 1].components(separatedBy: ".").first?.components(separatedBy: "-") else {
            return nil
        }
        
        let firstDigit = ratingStr[ratingStr.count - 2]
        let secondDigit = ratingStr[ratingStr.count - 1]
        
        return Double("\(firstDigit).\(secondDigit)")
    }
    
    private func extractedGUID(from guid: String) -> String {
        // Sample format for the url on which rating will be extracted
        // top-sellers_toys-and-games_toys-and-games_B01MRG7T0D
        let components = guid.components(separatedBy: "_")
        
        return components.last ?? ""
    }
}

//
//  FeedPresenter.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxSwift

class FeedPresenter {
    weak var view: IFeedView?
    var repository: IFeedRepository
    
    let disposeBag = DisposeBag()
    
    let ratingThreshold: Double = 4.5
    let secondRatingThreshold: Double = 4.0
    
    init(view: IFeedView, repository: IFeedRepository) {
        self.view = view
        self.repository = repository
    }
    
    var previouslySearchedString: String?
    
    func searchProducts(for searchString: String) {
        view?.setProducts(products: [])
        view?.reloadData()
        
        return repository.fetchProducts()
                .map({ (products) -> [Product] in
                    let nameFilteredProducts = products
                            .filter({ (product) -> Bool in
                                if searchString.isEmpty {
                                    return true
                                }
                                
                                if product.title.lowercased().contains(searchString.lowercased()) {
                                    return true
                                } else {
                                    return false
                                }
                            })
                    let ratingHighThresholdFilteredProducts = nameFilteredProducts
                            .filter({ (product) -> Bool in
                                // Check if rating is less than 4.5
                                // remove if they are
                                if product.rating >= self.ratingThreshold {
                                    return true
                                } else {
                                    return false
                                }
                            })
                    
                    if !ratingHighThresholdFilteredProducts.isEmpty {
                        return ratingHighThresholdFilteredProducts
                    } else {
                        // If previous filter is empty,
                        // then try including 4.0 ratings
                        let ratingSemiHighThresholdFilteredProducts = nameFilteredProducts
                            .filter({ (product) -> Bool in
                                // Check if rating is less than 4.0
                                // remove if they are
                                if product.rating >= self.secondRatingThreshold {
                                    return true
                                } else {
                                    return false
                                }
                            })
                        
                        return ratingSemiHighThresholdFilteredProducts
                    }
                })
                .map({ (products) -> [Product] in
                    // Remove duplicates
                    return Array(Set(products.map { $0 } ))
                })
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { (products) in
                    self.view?.setProducts(products: products)
                    self.view?.reloadData()
                })
                .disposed(by: disposeBag)
    }
}

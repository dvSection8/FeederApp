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
    
    let ratingThreshold: Double = 0
    
    init(view: IFeedView, repository: IFeedRepository) {
        self.view = view
        self.repository = repository
    }
    
    func searchProducts(for searchString: String) {
        repository.fetchProducts()
            .map({ (products) -> [Product] in
                return products.filter({ (product) -> Bool in
                            // Check if rating is less than 4.5
                            // remove if they are
                            if product.rating >= self.ratingThreshold {
                                return true
                            } else {
                                return false
                            }
                        })
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
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (products) in
                self.view?.setProducts(products: products)
                self.view?.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

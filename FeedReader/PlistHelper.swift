//
//  PlistHelper.swift
//  FeedReader
//
//  Created by Ron Daryl Magno on 2/6/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

import Foundation

public enum PlistKey {
    case urls

    func value() -> String {
        switch self {
        case .urls:
            return "urls"
        }
    }
}
public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }

    public func configuration<T>(_ key: PlistKey) -> T? {
        switch key {
        case .urls:
            return infoDict[PlistKey.urls.value()] as? T
        }
    }
}

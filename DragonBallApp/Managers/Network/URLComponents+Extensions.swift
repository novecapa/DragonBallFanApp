//
//  URLComponents+Extensions.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

import Foundation

extension URLComponents {
    mutating func addQueryParams(_ queryParams: [String: Any?]?) {
        guard let queryParams else {
            return
        }
        queryItems = queryParams.compactMap { key, value in
                if let stringValue = value as? String,
                   !stringValue.isEmpty {
                    return URLQueryItem(name: key, value: stringValue)
                }
                if let otherValue = value,
                   let stringValue = String(describing: otherValue)
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !stringValue.isEmpty {
                    return URLQueryItem(name: key, value: stringValue)
            }
            return nil
        }
    }
}

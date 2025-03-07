//
//  URLSessionProtocol.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

import Foundation

protocol URLSessionProtocol {
    func getDataFrom<T: Decodable>(_ request: URLRequest,
                                   type: T.Type) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func getDataFrom<T: Decodable>(_ request: URLRequest,
                                   type: T.Type) async throws -> (Data, URLResponse) {
        try await data(for: request)
    }
}

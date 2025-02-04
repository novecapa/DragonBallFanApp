//
//  NetworkClientProtocol.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

import Foundation

protocol NetworkClientProtocol {
    func call<T: Decodable>(urlString: String,
                            method: NetworkMethod,
                            queryParams: [String: Any?]?,
                            of type: T.Type) async throws -> T
}

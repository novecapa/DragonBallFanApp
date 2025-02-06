//
//  CharactersRemote.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

import Foundation

protocol CharactersRemoteProtocol {
    func fetchCharacters(_ page: Int) async throws -> CharactersDTO
}

final class CharactersRemote {

    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
}
// MARK: - CharactersRemoteProtocol
extension CharactersRemote: CharactersRemoteProtocol {
    func fetchCharacters(_ page: Int) async throws -> CharactersDTO {
        let url = Endpoints.characters.rawValue
        let queryParams = [
            "page": page,
            "limit": 10
        ]
        return try await networkClient.call(urlString: url,
                                            method: .get,
                                            queryParams: queryParams,
                                            of: CharactersDTO.self)
    }
}

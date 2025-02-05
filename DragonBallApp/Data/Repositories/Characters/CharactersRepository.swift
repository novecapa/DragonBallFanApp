//
//  CharactersRepository.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation

protocol CharactersRepositoryProtocol {
    func fetchCharacters(_ page: Int) async throws -> CharactersEntity
}

final class CharactersRepository {

    private let utils: UtilsProtocol
    private let remote: CharactersRemoteProtocol
    init(utils: UtilsProtocol = Utils(),
         remote: CharactersRemoteProtocol) {
        self.utils = utils
        self.remote = remote
    }
}

// MARK: - CharactersRepositoryProtocol
extension CharactersRepository: CharactersRepositoryProtocol {
    func fetchCharacters(_ page: Int) async throws -> CharactersEntity {
        // TODO: Chek internet connection
        try await remote.fetchCharacters(page).toEntity
    }
}

// MARK: - CharactersDTO
fileprivate extension CharactersDTO {
    var toEntity: CharactersEntity {
        CharactersEntity(character: self.items.map { $0.toEntity },
                         links: self.links.toEntity)
    }
}

// MARK: - ItemDTO
fileprivate extension ItemDTO {
    var toEntity: CharacterEntity {
        CharacterEntity(
            id: self.id,
            name: self.name,
            kii: self.kii,
            maxKi: self.maxKi,
            race: self.race,
            gender: self.gender,
            description: self.description,
            image: self.image,
            affiliation: self.affiliation
        )
    }
}

// MARK: - LinksDTO
fileprivate extension LinksDTO {
    var toEntity: LinksEntity {
        LinksEntity(
            first: self.first,
            previous: self.previous,
            next: self.next,
            last: self.last
        )
    }
}

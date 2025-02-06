//
//  CharactersUseCase.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation

protocol CharactersUseCaseProtocol {
    func fetchCharacters(_ page: Int) async throws -> CharactersEntity
    func fetchCharacter(_ id: Int) async throws -> CharacterEntity?
}

final class CharactersUseCase {

    private let repository: CharactersRepositoryProtocol
    init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    }
}

extension CharactersUseCase: CharactersUseCaseProtocol {
    func fetchCharacters(_ page: Int) async throws -> CharactersEntity {
        try await repository.fetchCharacters(page)
    }

    func fetchCharacter(_ id: Int) async throws -> CharacterEntity? {
        try await repository.fetchCharacter(id)
    }
}

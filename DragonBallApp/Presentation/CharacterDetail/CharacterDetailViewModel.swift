//
//  CharacterDetailViewModel.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

final class CharacterDetailViewModel: ObservableObject {

    @Published var character: CharacterEntity?

    private let characterId: Int
    private let useCase: CharactersUseCaseProtocol

    init(characterId: Int,
         useCase: CharactersUseCaseProtocol) {
        self.characterId = characterId
        self.useCase = useCase
    }
}

// MARK: - Private methods {
private extension CharacterDetailViewModel {
    private func handleError(_ error: Error) {}
}

// MARK: - Public methods
extension CharacterDetailViewModel {
    func fetchCharacter() {
        Task { @MainActor in
            do {
                character = try await useCase.fetchCharacter(characterId)
            } catch {
                handleError(error)
            }
        }
    }
}

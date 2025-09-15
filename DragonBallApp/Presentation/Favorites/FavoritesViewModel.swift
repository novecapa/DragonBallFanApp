//
//  FavoritesViewModel.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

final class FavoritesViewModel: ObservableObject {

    @Published var characters: [CharacterEntity] = [] {
        didSet {
            print("characters: \(characters.count)")
        }
    }
    @State var rotation: Int = 0

    // MARK: - Private
    private let useCase: CharactersUseCaseProtocol

    init(useCase: CharactersUseCaseProtocol) {
        self.useCase = useCase
    }

    // TODO: - 
    private func handleError(_ error: Error) {}
}

// MARK: - Public methods

extension FavoritesViewModel {
    func getFavorites() {
        Task { @MainActor in
            do {
                characters = try await useCase.fetchCharacters(1).character
            } catch {
                handleError(error)
            }
        }
    }
}

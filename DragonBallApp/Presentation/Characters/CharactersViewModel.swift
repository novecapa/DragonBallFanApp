//
//  CharactersViewModel.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

final class CharactersViewModel: ObservableObject {

    @Published var showLoader: Bool = false
    @Published var characters: [CharacterEntity] = []
    @Published var refreshId: Int = -1
    @Published var favorites: [Int] = []

    private(set) var currentPage = 1
    private var hasNewPage = true

    private let useCase: CharactersUseCaseProtocol
    private let onNavigation: (Int) -> Void
    init(useCase: CharactersUseCaseProtocol,
         onNavigation: @escaping (Int) -> Void) {
        self.useCase = useCase
        self.onNavigation = onNavigation
    }
}

// MARK: - Private methods
private extension CharactersViewModel {

    private func handleError(_ error: Error) {}

    private var canLoadNewPage: Bool {
        return hasNewPage && !showLoader
    }

    private func resetPagination() {
        currentPage = 1
        hasNewPage = true
    }

    private func populateArticles(_ result: CharactersEntity) {
        if currentPage == 1 {
            characters.removeAll()
        }
        characters.append(contentsOf: result.character)
        currentPage += result.addNewPage
        hasNewPage = result.addNewPage > 0
    }
}

// MARK: - Public methods
extension CharactersViewModel {
    func fetchCaracters() {
        guard canLoadNewPage else { return }
        Task { @MainActor in
            do {
                showLoader = true
                let result = try await useCase.fetchCharacters(currentPage)
                self.populateArticles(result)
                self.showLoader = false
                reloadFavorites()
            } catch {
                showLoader = false
                handleError(error)
            }
        }
    }

    private func reloadFavorites() {
        Task { @MainActor in
            do {
                self.favorites = try await useCase.favoriteListIds()
            } catch {
                handleError(error)
            }
        }
    }

    func navigateToDetail(_ id: Int) {
        onNavigation(id)
    }

    func isFavorite(_ character: CharacterEntity) -> Bool {
        return favorites.first { characterId in
            characterId == character.id
        } != nil
    }

    func setFavorite(_ character: CharacterEntity) {
        Task { @MainActor in
            do {
                try await useCase.setFavorite(character)
                reloadFavorites()
                refreshId = character.id
            } catch {
                handleError(error)
            }
        }
    }
}

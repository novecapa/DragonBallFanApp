//
//  CharactersDatabase.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation
import SwiftData

protocol CharactersDatabaseProtocol {
    func saveCharacters(characters: [SDCharacter]) async throws
    func getcharater(by id: Int) async throws -> SDCharacter?
    func getCharacters() async throws -> [SDCharacter]
    func setFavorite(_ character: SDCharacter) async throws
    func favoriteList() async throws -> [SDCharacterFav]
    func favoriteListCharacter() async throws -> [SDCharacter]
}

final class CharactersDatabase: CharactersDatabaseProtocol {

    // MARK: - Private
    private let database: SwiftDataContainerProtocol

    // MARK: - Init
    init(database: SwiftDataContainerProtocol) {
        self.database = database
    }

    func saveCharacters(characters: [SDCharacter]) async throws {
        try await MainActor.run {
            characters.forEach { cha in
                database.container.mainContext.insert(cha)
            }
            try database.container.mainContext.save()
        }
    }

    func getcharater(by id: Int) async throws -> SDCharacter? {
        return try await MainActor.run {
            let fetchDescriptor = FetchDescriptor<SDCharacter>(predicate: #Predicate {
                $0.id == id
            }, sortBy: [SortDescriptor<SDCharacter>(\.id)])
            return try database.container.mainContext.fetch(fetchDescriptor).first
        }
    }

    func getCharacters() async throws -> [SDCharacter] {
        return try await MainActor.run {
            let fetchDescription = FetchDescriptor<SDCharacter>(
                predicate: nil,
                sortBy: [SortDescriptor<SDCharacter>(\.id, order: .forward)]
            )
            return try database.container.mainContext.fetch(fetchDescription)
        }
    }

    func setFavorite(_ character: SDCharacter) async throws {
        let characterId = character.id
        let fetchDescriptor = FetchDescriptor<SDCharacterFav>(predicate: #Predicate {
            $0.characterId == characterId
        })
        try await MainActor.run {
            if let result = try database.container.mainContext.fetch(fetchDescriptor).first {
                database.container.mainContext.delete(result)
            } else {
                database.container.mainContext.insert(SDCharacterFav(characterId: characterId))
            }
            try database.container.mainContext.save()
        }
    }

    func favoriteList() async throws -> [SDCharacterFav] {
        let fetchDescription = FetchDescriptor<SDCharacterFav>(
            predicate: nil,
            sortBy: [SortDescriptor<SDCharacterFav>(\.characterId, order: .forward)]
        )
        return try await MainActor.run {
            return try database.container.mainContext.fetch(fetchDescription)
        }
    }

    func favoriteListCharacter() async throws -> [SDCharacter] {
        let fetchFavorites = FetchDescriptor<SDCharacterFav>(
            predicate: nil,
            sortBy: [SortDescriptor<SDCharacterFav>(\.characterId, order: .forward)]
        )
        return try await MainActor.run {
            let ids = try database.container.mainContext.fetch(fetchFavorites).compactMap { $0.characterId }
            let fetchDescriptor = FetchDescriptor<SDCharacter>(predicate: #Predicate {
                ids.contains($0.id)
            }, sortBy: [SortDescriptor<SDCharacter>(\.id)])
            return try database.container.mainContext.fetch(fetchDescriptor)
        }
    }
}

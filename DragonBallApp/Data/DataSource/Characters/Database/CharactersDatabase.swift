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
    func getCharacters() async throws -> [SDCharacter]
}

final class CharactersDatabase: CharactersDatabaseProtocol {

    private let database: SwiftDataContainerProtocol
    init(database: SwiftDataContainerProtocol) {
        self.database = database
    }

    @MainActor
    func saveCharacters(characters: [SDCharacter]) async throws {
        characters.forEach { character in
            database.container.mainContext.insert(character)
        }
        try database.container.mainContext.save()
    }

    @MainActor
    func getCharacters() async throws -> [SDCharacter] {
        let fetchDescription = FetchDescriptor<SDCharacter>(
            predicate: nil,
            sortBy: [SortDescriptor<SDCharacter>(\.name, order: .forward)]
        )
        return try database.container.mainContext.fetch(fetchDescription)
    }
}

//
//  CharactersDatabase.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation
import SwiftData

@MainActor
protocol CharactersDatabaseProtocol {
    func saveCharacters(characters: [SDCharacter]) throws
    func getcharater(by id: Int) throws -> SDCharacter?
    func getCharacters() throws -> [SDCharacter]
    func setFavorite(_ character: SDCharacter) throws
    func favoriteList() throws -> [SDCharacterFav]
}

@MainActor
final class CharactersDatabase: CharactersDatabaseProtocol {

    private let database: SwiftDataContainerProtocol
    init(database: SwiftDataContainerProtocol) {
        self.database = database
    }

    func saveCharacters(characters: [SDCharacter]) throws {
        characters.forEach { cha in
            database.container.mainContext.insert(cha)
        }
        try database.container.mainContext.save()
    }

    func getcharater(by id: Int) throws -> SDCharacter? {
        let fetchDescriptor = FetchDescriptor<SDCharacter>(predicate: #Predicate {
            $0.id == id
        }, sortBy: [SortDescriptor<SDCharacter>(\.id)])
        return try database.container.mainContext.fetch(fetchDescriptor).first
    }

    func getCharacters() throws -> [SDCharacter] {
        let fetchDescription = FetchDescriptor<SDCharacter>(
            predicate: nil,
            sortBy: [SortDescriptor<SDCharacter>(\.id, order: .forward)]
        )
        return try database.container.mainContext.fetch(fetchDescription)
    }

    func setFavorite(_ character: SDCharacter) throws {
        let characterId = character.id
        let fetchDescriptor = FetchDescriptor<SDCharacterFav>(predicate: #Predicate {
            $0.characterId == characterId
        })
        if let result = try database.container.mainContext.fetch(fetchDescriptor).first {
            database.container.mainContext.delete(result)
        } else {
            database.container.mainContext.insert(SDCharacterFav(characterId: characterId))
        }
        try database.container.mainContext.save()
    }

    func favoriteList() throws -> [SDCharacterFav] {
        let fetchDescription = FetchDescriptor<SDCharacterFav>(
            predicate: nil,
            sortBy: [SortDescriptor<SDCharacterFav>(\.characterId, order: .forward)]
        )
        return try database.container.mainContext.fetch(fetchDescription)
    }
}

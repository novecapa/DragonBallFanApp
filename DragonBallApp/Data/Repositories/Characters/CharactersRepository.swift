//
//  CharactersRepository.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation

protocol CharactersRepositoryProtocol {
    func fetchCharacters(_ page: Int) async throws -> CharactersEntity
    func fetchCharacter(_ id: Int) async throws -> CharacterEntity?
    func setFavorite(_ character: CharacterEntity) async throws
    func favoriteListIds() async throws -> [Int]
    func favoriteList() async throws -> [CharacterEntity]
}

final class CharactersRepository {

    private let utils: UtilsProtocol
    private let remote: CharactersRemoteProtocol
    private let database: CharactersDatabaseProtocol
    init(utils: UtilsProtocol = Utils(),
         remote: CharactersRemoteProtocol,
         database: CharactersDatabaseProtocol) {
        self.utils = utils
        self.remote = remote
        self.database = database
    }
}

// MARK: - CharactersRepositoryProtocol

extension CharactersRepository: CharactersRepositoryProtocol {
    func fetchCharacters(_ page: Int) async throws -> CharactersEntity {
        if page == 1 && !utils.existsConnection {
            let result = try await database.getCharacters()
            return CharactersEntity(character: result.map { $0.toEntity }, links: .empty)
        }
        let result = try await remote.fetchCharacters(page)
        try await database.saveCharacters(characters: result.items.map { $0.toDatabase })
        return result.toEntity
    }

    func fetchCharacter(_ id: Int) async throws -> CharacterEntity? {
        if !utils.existsConnection {
            let character = try await database.getcharater(by: id)
            return character?.toEntity
        }
        let result = try await remote.fetchCharacter(id)
        try await database.saveCharacters(characters: [result.toDatabase])
        return result.toEntity
    }

    func setFavorite(_ character: CharacterEntity) async throws {
        try await database.setFavorite(character.toDatabase)
    }

    func favoriteListIds() async throws -> [Int] {
        try await database.favoriteList().compactMap { $0.characterId }
    }

    func favoriteList() async throws -> [CharacterEntity] {
        try await database.favoriteListCharacter().map { $0.toEntity }
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
            affiliation: self.affiliation,
            originPlanet: self.originPlanet?.toEntity,
            transformations: self.transformations?.map { $0.toEntity }
        )
    }

    var toDatabase: SDCharacter {
        SDCharacter(
            id: self.id,
            name: self.name,
            kii: self.kii,
            maxKi: self.maxKi,
            race: self.race,
            gender: self.gender,
            desc: self.description,
            image: self.image,
            affiliation: self.affiliation,
            originPlanet: self.originPlanet?.toDatabase,
            transformations: self.transformations?.map { $0.toDatabase }
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

// MARK: - OriginPlanetDTO

fileprivate extension OriginPlanetDTO {
    var toEntity: OriginPlanetEntity {
        OriginPlanetEntity(
            id: self.id,
            name: self.name,
            isDestroyed: self.isDestroyed,
            description: self.description,
            image: self.image
        )
    }

    var toDatabase: SDOriginPlanet {
        SDOriginPlanet(
            id: self.id,
            name: self.name,
            isDestroyed: self.isDestroyed,
            desc: self.description,
            image: self.image
        )
    }
}

// MARK: - TransformationDTO

fileprivate extension TransformationDTO {
    var toEntity: TransformationEntity {
        TransformationEntity(
            id: self.id,
            name: self.name,
            image: self.image,
            kii: self.kii
        )
    }

    var toDatabase: SDTransformation {
        SDTransformation(
            id: self.id,
            name: self.name,
            image: self.image,
            kii: self.kii
        )
    }
}

// MARK: - SDCharacter

fileprivate extension SDCharacter {
    var toEntity: CharacterEntity {
        CharacterEntity(
            id: self.id,
            name: self.name,
            kii: self.kii,
            maxKi: self.maxKi,
            race: self.race,
            gender: self.gender,
            description: self.desc,
            image: self.image,
            affiliation: self.affiliation,
            originPlanet: self.originPlanet?.toEntity,
            transformations: self.transformations?.map { $0.toEntity }
        )
    }
}

// MARK: - SDCharacterFav

fileprivate extension SDCharacterFav {}

// MARK: - SDOriginPlanet

fileprivate extension SDOriginPlanet {
    var toEntity: OriginPlanetEntity {
        OriginPlanetEntity(
            id: self.id,
            name: self.name,
            isDestroyed: self.isDestroyed,
            description: self.desc,
            image: self.image
        )
    }
}

// MARK: - SDOriginPlanet

fileprivate extension SDTransformation {
    var toEntity: TransformationEntity {
        TransformationEntity(
            id: self.id,
            name: self.name,
            image: self.image,
            kii: self.kii
        )
    }
}

// MARK: - CharacterEntity

fileprivate extension CharacterEntity {
    var toDatabase: SDCharacter {
        SDCharacter(
            id: self.id,
            name: self.name,
            kii: self.kii,
            maxKi: self.maxKi,
            race: self.race,
            gender: self.gender,
            desc: self.description,
            image: self.image,
            affiliation: self.affiliation,
            originPlanet: self.originPlanet?.toDatabase,
            transformations: self.transformations?.map {
                $0.toDatabase
            })
    }
}

// MARK: - OriginPlanetEntity

fileprivate extension OriginPlanetEntity {
    var toDatabase: SDOriginPlanet {
        SDOriginPlanet(
            id: self.id,
            name: self.name,
            isDestroyed: self.isDestroyed,
            desc: self.description,
            image: self.image
        )
    }
}

// MARK: - TransformationEntity

fileprivate extension TransformationEntity {
    var toDatabase: SDTransformation {
        SDTransformation(
            id: self.id,
            name: self.name,
            image: self.image,
            kii: self.kii
        )
    }
}

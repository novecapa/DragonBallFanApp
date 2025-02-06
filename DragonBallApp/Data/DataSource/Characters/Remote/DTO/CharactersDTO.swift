//
//  CharactersDTO.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

// MARK: - CharactersDTO
struct CharactersDTO: Codable {
    let items: [ItemDTO]
    let meta: MetaDTO
    let links: LinksDTO
}

// MARK: - ItemDTO
struct ItemDTO: Codable {
    let id: Int
    let name: String
    let kii: String
    let maxKi: String
    let race: String
    let gender: String
    let description: String
    let image: String
    let affiliation: String
    let originPlanet: OriginPlanetDTO?
    let transformations: [TransformationDTO]?

    enum CodingKeys: String, CodingKey {
        case id, name, maxKi, race, gender, description, image, affiliation
        case kii = "ki"
        case originPlanet
        case transformations
    }
}

// MARK: - LinksDTO
struct LinksDTO: Codable {
    let first: String
    let previous: String
    let next: String
    let last: String
}

// MARK: - MetaDTO
struct MetaDTO: Codable {
    let totalItems: Int
    let itemCount: Int
    let itemsPerPage: Int
    let totalPages: Int
    let currentPage: Int
}

// MARK: - OriginPlanetDTO
struct OriginPlanetDTO: Codable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
}

// MARK: - TransformationDTO
struct TransformationDTO: Codable {
    let id: Int
    let name: String
    let image: String
    let kii: String

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case kii = "ki"
    }
}

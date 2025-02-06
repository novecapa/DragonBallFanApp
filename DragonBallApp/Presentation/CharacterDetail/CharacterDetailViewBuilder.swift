//
//  CharacterDetailViewBuilder.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

protocol CharacterDetailViewBuilderProtocol {
	func build(characterId: Int) -> CharacterDetailView
}

final class CharacterDetailViewBuilder: CharacterDetailViewBuilderProtocol {
	func build(characterId: Int) -> CharacterDetailView {
        let network = NetworkClient(urlSession: URLSession.shared)
        let remote = CharactersRemote(networkClient: network)
        let database = SwiftDataContainer(isStoredInMemoryOnly: false)
        let local = CharactersDatabase(database: database)
        let repository = CharactersRepository(remote: remote, database: local)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = CharacterDetailViewModel(characterId: characterId, useCase: useCase)
        let view = CharacterDetailView(viewModel: viewModel)
		return view
	}
}

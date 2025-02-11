//
//  CharacterDetailViewBuilderMock.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

@MainActor
final class CharacterDetailViewBuilderMock: CharacterDetailViewBuilderProtocol {
	func build(characterId: Int) -> CharacterDetailView {
        let urlSession = URLSessionMock(statusCode: 200)
        let network = NetworkClient(urlSession: urlSession)
        let remote = CharactersRemote(networkClient: network)
        let database = SwiftDataContainer(isStoredInMemoryOnly: true)
        let local = CharactersDatabase(database: database)
        let repository = CharactersRepository(remote: remote, database: local)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = CharacterDetailViewModel(characterId: characterId, useCase: useCase)
        let view = CharacterDetailView(viewModel: viewModel)
		return view
	}
}

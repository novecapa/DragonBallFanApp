//
//  CharacterDetailViewBuilderMock.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

final class CharacterDetailViewBuilderMock: CharacterDetailViewBuilderProtocol {
	func build() -> CharacterDetailView {
        let urlSession = URLSessionMock(statusCode: 200)
        let network = NetworkClient(urlSession: urlSession)
        let remote = CharactersRemote(networkClient: network)
        let database = SwiftDataContainer(isStoredInMemoryOnly: false)
        let local = CharactersDatabase(database: database)
        let repository = CharactersRepository(remote: remote, database: local)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = CharacterDetailViewModel(useCase: useCase)
        let view = CharacterDetailView(viewModel: viewModel)
		return view
	}
}

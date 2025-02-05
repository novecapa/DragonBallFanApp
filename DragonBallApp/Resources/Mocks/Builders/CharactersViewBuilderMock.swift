//
//  CharactersViewBuilderMock.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

final class CharactersViewBuilderMock: CharactersViewBuilderProtocol {
	func build() -> CharactersView {
        let urlSession = URLSessionMock(statusCode: 200)
        let network = NetworkClient(urlSession: urlSession)
        let remote = CharactersRemote(networkClient: network)
        let database = SwiftDataContainer(isStoredInMemoryOnly: true)
        let local = CharactersDatabase(database: database)
        let repository = CharactersRepository(remote: remote, database: local)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = CharactersViewModel(useCase: useCase)
        let view = CharactersView(viewModel: viewModel)
		return view
	}
}

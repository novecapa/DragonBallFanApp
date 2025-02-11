//
//  FavoritesViewBuilderMock.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

final class FavoritesViewBuilderMock: FavoritesViewBuilderProtocol {
	func build() -> FavoritesView {
        let urlSession = URLSessionMock(statusCode: 200)
        let network = NetworkClient(urlSession: urlSession)
        let remote = CharactersRemote(networkClient: network)
        let database = SwiftDataContainer(isStoredInMemoryOnly: true)
        let local = CharactersDatabase(database: database)
        let repository = CharactersRepository(remote: remote, database: local)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = FavoritesViewModel(useCase: useCase)
        let view = FavoritesView(viewModel: viewModel)
		return view
	}
}

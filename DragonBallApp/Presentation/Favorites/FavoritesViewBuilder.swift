//
//  FavoritesViewBuilder.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

protocol FavoritesViewBuilderProtocol {
	func build() -> FavoritesView
}

final class FavoritesViewBuilder: FavoritesViewBuilderProtocol {
	func build() -> FavoritesView {
        let network = NetworkClient(urlSession: URLSession.shared)
        let remote = CharactersRemote(networkClient: network)
        let database = SwiftDataContainer(isStoredInMemoryOnly: false)
        let local = CharactersDatabase(database: database)
        let repository = CharactersRepository(remote: remote, database: local)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = FavoritesViewModel(useCase: useCase)
        let view = FavoritesView(viewModel: viewModel)
		return view
	}
}

//
//  CharactersViewBuilder.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

protocol CharactersViewBuilderProtocol {
	func build() -> CharactersView
}

final class CharactersViewBuilder: CharactersViewBuilderProtocol {
	func build() -> CharactersView {
        let network = NetworkClient(urlSession: URLSession.shared)
        let remote = CharactersRemote(networkClient: network)
        let database = SwiftDataContainer(isStoredInMemoryOnly: false)
        let local = CharactersDatabase(database: database)
        let repository = CharactersRepository(remote: remote, database: local)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = CharactersViewModel(useCase: useCase)
        let view = CharactersView(viewModel: viewModel)
		return view
	}
}

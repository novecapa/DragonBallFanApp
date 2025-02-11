//
//  CharactersViewBuilder.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

@MainActor
protocol CharactersViewBuilderProtocol {
	func build(onNavigation: @escaping (Int) -> Void) -> CharactersView
}

@MainActor
final class CharactersViewBuilder: CharactersViewBuilderProtocol {
	func build(onNavigation: @escaping (Int) -> Void) -> CharactersView {
        let network = NetworkClient(urlSession: URLSession.shared)
        let remote = CharactersRemote(networkClient: network)
        let database = SwiftDataContainer(isStoredInMemoryOnly: false)
        let local = CharactersDatabase(database: database)
        let repository = CharactersRepository(remote: remote, database: local)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = CharactersViewModel(useCase: useCase, onNavigation: onNavigation)
        let view = CharactersView(viewModel: viewModel)
		return view
	}
}

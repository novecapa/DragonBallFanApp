//
//  CharactersView.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

struct CharactersView: View {

	@ObservedObject var viewModel: CharactersViewModel

    var body: some View {
        Text("CharactersView")
    }
}

#Preview {
    CharactersViewBuilderMock().build()
}

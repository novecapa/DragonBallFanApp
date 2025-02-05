//
//  CharacterDetailView.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

struct CharacterDetailView: View {

	@ObservedObject var viewModel: CharacterDetailViewModel

    var body: some View {
        Text("CharacterDetailView")
    }
}

#Preview {
    CharacterDetailViewBuilderMock().build()
}

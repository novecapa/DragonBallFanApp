//
//  CharactersView.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

struct CharactersView: View {

    enum Constants {
        static let columnNumber: CGFloat = 2
        static let columnSpacing: CGFloat = 2
    }

	@ObservedObject var viewModel: CharactersViewModel

    private let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: Constants.columnSpacing),
        GridItem(.flexible(), spacing: Constants.columnSpacing)
    ]

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: Constants.columnSpacing) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            Text(character.name)
                                .frame(width: geometry.size.width / 2, height: geometry.size.width / 1.5)
                                .background(.dbYellow)
                                .onAppear {
                                    if character == viewModel.characters.last {
                                        viewModel.fetchCaracters()
                                    }
                                }
                        }
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .onAppear {
            viewModel.fetchCaracters()
        }
    }
}

#Preview {
    CharactersViewBuilderMock().build()
}

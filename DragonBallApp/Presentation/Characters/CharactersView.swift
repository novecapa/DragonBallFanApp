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
        static let columnSpacing: CGFloat = 0
    }

	@ObservedObject var viewModel: CharactersViewModel

    private let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: Constants.columnSpacing),
        GridItem(.flexible(), spacing: Constants.columnSpacing)
    ]

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: gridItems, spacing: Constants.columnSpacing) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            VStack(spacing: 0) {
                                AsyncImageLoader(url: character.imageURL)
                                    .padding(18)
                                    .frame(width: geometry.size.width / 2,
                                           height: geometry.size.width / 1.5)
                                Text(character.name)
                                    .font(.notoSans(.medium(16)))
                                Text(character.name)
                                    .font(.notoSans(.medium(12)))
                                Text(character.name)
                                    .font(.notoSans(.medium(12)))
                                    .padding(.bottom, 12)
                            }
                            .background(content: {
                                Image.cardBackground()
                                    .resizable()
                                    .cornerRadius(6)
                                    .padding(4)
                            })
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
        .background(.dbBlack)
    }
}

#Preview {
    CharactersViewBuilderMock().build()
}

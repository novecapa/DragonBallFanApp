//
//  FavoritesView.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

struct FavoritesView: View {

	@ObservedObject var viewModel: FavoritesViewModel
    let visibleCardCount: Int = 2

    var body: some View {
        ZStack {
            ForEach(viewModel.characters, id: \.id) { char in
                let index = viewModel.characters.firstIndex(of: char) ?? 0
                let zIndex = Double(viewModel.characters.count - index)
                LoopingStack(index: index, count: viewModel.characters.count, visibleCardsCount: visibleCardCount) {
                    AsyncImageLoader(url: char.imageURL)
                        .padding(18)
                        .frame(width: 320,
                               height: 320 * 1.5)
                        .background(content: {
                            Image.cardBackground()
                                .resizable()
                                .cornerRadius(6)
                                .padding(4)
                        })
                }
                .zIndex(zIndex)
            }
        }
        .onAppear {
            viewModel.getFavorites()
        }
    }
}

struct LoopingStack<Content: View>: View {

    var index: Int
    var count: Int
    var visibleCardsCount: Int

    @State private var offset: CGFloat = .zero
    @State private var viewSize: CGSize = .zero

    @ViewBuilder var content: Content

    var body: some View {

        let extraOffset = min(CGFloat(index) * 20, CGFloat(visibleCardsCount) * 20)
        let scale = 1 - min(CGFloat(index) * 0.07, CGFloat(visibleCardsCount) * 0.07)
        let rotationDegree: CGFloat = -30
        let rotation = max(min(-offset / viewSize.width, 1), 0) * rotationDegree

        content
            .onGeometryChange(for: CGSize.self, of: { $0.size }, action: { viewSize = $0 })
            .offset(x: extraOffset)
            .scaleEffect(scale, anchor: .trailing)
            .offset(x: offset)
            .rotation3DEffect(.init(degrees: rotation), axis: (0, 1, 0), anchor: .center, perspective: 0.5)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let xOffset = -max(-value.translation.width, 0)
                        offset = xOffset
                    }
                    .onEnded { value in
                        let xVelocity = max(-value.velocity.width / 5, 0)

                        if (offset + xVelocity) > (viewSize.width * 0.65) {
                            pushToNextCard()
                        } else {
                            withAnimation(.smooth(duration: 0.3, extraBounce: 0)) {
                                offset = .zero
                            }
                        }
                    },
                isEnabled: index == 0
            )
    }

    private func pushToNextCard() {
        withAnimation(.smooth(duration: 0.25, extraBounce: 0).logicallyComplete(after: 0.15),
                      completionCriteria: .logicallyComplete) {
            offset = -viewSize.width
        } completion: {
            withAnimation(.smooth(duration: 0.25, extraBounce: 0)) {
                offset = .zero
            }
        }
    }
}

extension SubviewsCollection {
    func index(_ item: SubviewsCollection.Element) -> Int {
        firstIndex(where: { $0.id == item.id }) ?? 0
    }
}
#Preview {
    FavoritesViewBuilderMock().build()
}

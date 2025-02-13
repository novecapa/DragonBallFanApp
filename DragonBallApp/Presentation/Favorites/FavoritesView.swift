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

    @State private var rotation: Int = 0
    var body: some View {

        let cccCount = viewModel.characters.count == 0 ? 1 : viewModel.characters.count
        let moveToIndex = rotation % cccCount
        let rotatatedElements = Array(
            viewModel.characters[moveToIndex...]
        ) + Array(
            viewModel.characters[..<moveToIndex]
        )

        ZStack {
            Color.dbBlack
            ForEach(rotatatedElements, id: \.id) { char in
                let index = rotatatedElements.firstIndex(of: char) ?? 0
                let zIndex = Double(rotatatedElements.count - index)
                LoopingStack(index: index, count: rotatatedElements.count,
                             visibleCardsCount: visibleCardCount,
                             rotation: $rotation) {
                    VStack(spacing: 0) {
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
                            .cornerRadius(6)
                        Text(char.name)
                            .foregroundStyle(.dbYellow)
                            .font(.notoSans(.bold(16)))
                        Text(char.raceGender)
                            .foregroundStyle(.white)
                            .font(.notoSans(.medium(12)))
                            .padding(.top, 6)
                        HStack {
                            Text("Base KI:")
                                .foregroundStyle(.white)
                                .font(.notoSans(.medium(12)))
                            Text(char.kii)
                                .foregroundStyle(.dbYellow)
                                .font(.notoSans(.medium(12)))
                        }
                        HStack {
                            Text("Total KI:")
                                .foregroundStyle(.white)
                                .font(.notoSans(.medium(12)))
                            Text(char.maxKi)
                                .foregroundStyle(.dbYellow)
                                .font(.notoSans(.medium(12)))
                        }
                        Text(char.affiliation)
                            .foregroundStyle(.dbYellow)
                            .font(.notoSans(.bold(13)))
                            .padding(.bottom, 12)
                            .padding(.top, 6)
                    }
                    .border(.dbYellow, width: 6)
                    .cornerRadius(12)
                    .background(.dbBlack)
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
    @Binding var rotation: Int

    @State private var offset: CGFloat = .zero
    @State private var viewSize: CGSize = .zero

    @ViewBuilder var content: Content

    var body: some View {

        let extraOffset = min(CGFloat(index) * 12, CGFloat(visibleCardsCount) * 12)
        let scale = 1 - min(CGFloat(index) * 0.07, CGFloat(visibleCardsCount) * 0.07)
        let rotationDegree: CGFloat = -20
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
            rotation += 1
            withAnimation(.smooth(duration: 0.25, extraBounce: 0)) {
                offset = .zero
            }
        }
    }
}

#Preview {
    FavoritesViewBuilderMock().build()
}

//
//  FlashCardView.swift
//  Quitlet
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import SwiftUI
import SwiftUI

struct FlashCardsView: View {
    @Binding var module: FlashCardModule
    @State private var currentIndex = 0
    @State private var showTranslation = false
    @State private var offset: CGSize = .zero
    @State private var flashColor: Color = .white
    @State private var hideText = false
    
    @State private var localFlashCards: [FlashCard]
    @State private var liveCompletionPercentage: Double = 0.0

    init(module: Binding<FlashCardModule>) {
        _module = module
        _localFlashCards = State(initialValue: module.wrappedValue.flashCards)
    }

    var body: some View {
        VStack {
            if !localFlashCards.isEmpty {
                FlashCardView(card: localFlashCards[currentIndex], showTranslation: $showTranslation, offset: $offset, flashColor: $flashColor, hideText: $hideText) { isCorrect in
                    handleSwipe(isCorrect: isCorrect)
                }
                .onTapGesture {
                    showTranslation.toggle()
                }
            } else {
                Text("No cards available")
            }
        }
        .padding()
        .navigationTitle(module.name)
        .navigationBarItems(trailing: Text("Progress: \(Int(liveCompletionPercentage))%").font(.headline))
        .onAppear {
            module.resetViewedCards()
            localFlashCards = module.flashCards
            currentIndex = 0
            updateLiveCompletionPercentage()
        }
    }

    func handleSwipe(isCorrect: Bool) {
        guard !localFlashCards.isEmpty else { return }

        withAnimation {
            flashColor = isCorrect ? .green : .red
            hideText = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let card = localFlashCards[currentIndex]
            if isCorrect {
                module.markCardAsViewed(card)
            }

            localFlashCards.remove(at: currentIndex)
            if localFlashCards.isEmpty {
                currentIndex = 0
                module.updateBestCompletionPercentage()
            } else if currentIndex >= localFlashCards.count {
                currentIndex = 0
            }

            updateLiveCompletionPercentage()

            withAnimation {
                offset = .zero
                flashColor = .white
                hideText = false
            }

            showTranslation = false
        }
    }
    
    private func updateLiveCompletionPercentage() {
        liveCompletionPercentage = module.completionPercentage
    }
}

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
    @State private var showingAddCardView = false

    var body: some View {
        VStack {
            if !module.flashCards.isEmpty {
                FlashCardView(card: module.flashCards[currentIndex], showTranslation: $showTranslation, offset: $offset, flashColor: $flashColor, hideText: $hideText) { isCorrect in
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
        .navigationBarItems(trailing: Button(action: {
            showingAddCardView = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $showingAddCardView) {
            AddCardView(module: $module)
        }
    }

    func handleSwipe(isCorrect: Bool) {
        guard !module.flashCards.isEmpty else { return }

        withAnimation {
            flashColor = isCorrect ? .green : .red
            hideText = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if isCorrect {
                module.flashCards.remove(at: currentIndex)
            } else {
                module.flashCards.remove(at: currentIndex)
            }

            if module.flashCards.isEmpty {
                currentIndex = 0
            } else if currentIndex >= module.flashCards.count {
                currentIndex = 0
            }

            withAnimation {
                offset = .zero
                flashColor = .white
                hideText = false
            }
            
            showTranslation = false
        }
    }
}

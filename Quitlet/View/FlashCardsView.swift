//
//  FlashCardView.swift
//  Quitlet
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
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
    @State private var showingAddCardView = false
    @State private var showingCompletionView = false

    init(module: Binding<FlashCardModule>) {
        _module = module
        _localFlashCards = State(initialValue: module.wrappedValue.flashCards)
    }

    var body: some View {
        VStack {
            if showingCompletionView {
                CompletionView(completionPercentage: liveCompletionPercentage, onReplay: replayModule)
                    .transition(.opacity)
            } else {
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
                Spacer()
                VStack {
                    Text("Progress: \(Int(liveCompletionPercentage))%")
                        .font(.headline)
                        .padding()
                    ProgressView(value: Double(module.totalCardCount - localFlashCards.count), total: Double(module.totalCardCount))
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(height: 10)
                        .padding(.horizontal)
                }
            }
        }
        .padding()
        .navigationTitle(module.name)
        .navigationBarItems(trailing: HStack {
            Button(action: {
                showingAddCardView = true
            }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $showingAddCardView) {
                AddCardView(module: $module)
            }
        })
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
                showingCompletionView = true // Показать CompletionView
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
        // Обновляем процент правильного выполнения
        liveCompletionPercentage = module.completionPercentage
    }

    private func replayModule() {
        // Перезапускаем модуль
        localFlashCards = module.flashCards
        module.resetViewedCards()
        currentIndex = 0
        updateLiveCompletionPercentage()
        showingCompletionView = false
    }
}

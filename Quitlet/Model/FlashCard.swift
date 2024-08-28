//
//  FlashCard.swift
//  Quitlet
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation

import Foundation

struct FlashCard: Identifiable {
    let id = UUID()
    var question: String
    var answer: String
}
import SwiftUI

struct FlashCardModule: Identifiable {
    let id = UUID()
    var name: String
    var flashCards: [FlashCard]
    private(set) var viewedCardIDs: Set<UUID> = []
    var bestCompletionPercentage: Double = 0.0

    var totalCardCount: Int {
        return flashCards.count
    }

    var correctAnswerCount: Int {
        return viewedCardIDs.count
    }

    var completionPercentage: Double {
        guard totalCardCount > 0 else { return 0.0 }
        return (Double(correctAnswerCount) / Double(totalCardCount)) * 100
    }

    mutating func markCardAsViewed(_ card: FlashCard) {
        viewedCardIDs.insert(card.id)
    }

    mutating func resetViewedCards() {
        viewedCardIDs.removeAll()
    }

    mutating func updateBestCompletionPercentage() {
        let currentPercentage = completionPercentage
        if currentPercentage > bestCompletionPercentage {
            bestCompletionPercentage = currentPercentage
        }
    }
}

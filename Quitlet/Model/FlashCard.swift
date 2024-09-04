

import Foundation

import Foundation

struct FlashCard: Identifiable, Hashable {
    let id = UUID()
    var question: String
    var answer: String
}

import Foundation

struct FlashCardModule: Identifiable {
    let id = UUID() // Уникальный идентификатор
    var name: String
    var flashCards: [FlashCard]
    
    private(set) var viewedCards: Set<FlashCard> = []
    private(set) var bestCompletionPercentage: Double = 0.0

    // Вычисляемое свойство для получения общего количества карточек
    var totalCardCount: Int {
        return flashCards.count
    }

    // Вычисляемое свойство для получения количества просмотренных карточек
    var viewedCardCount: Int {
        return viewedCards.count
    }

    mutating func markCardAsViewed(_ card: FlashCard) {
        viewedCards.insert(card)
    }

    mutating func resetViewedCards() {
        viewedCards.removeAll()
    }

    var completionPercentage: Double {
        let totalCount = totalCardCount
        let correctCount = viewedCardCount
        return totalCount > 0 ? (Double(correctCount) / Double(totalCount)) * 100 : 0
    }

    mutating func updateBestCompletionPercentage() {
        let currentPercentage = completionPercentage
        if currentPercentage > bestCompletionPercentage {
            bestCompletionPercentage = currentPercentage
        }
    }
}

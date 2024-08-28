//
//  FlashCard.swift
//  Quitlet
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation

struct FlashCard: Identifiable {
    let id = UUID()
    var question: String
    var answer: String
}

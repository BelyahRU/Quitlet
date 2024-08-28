//
//  ModuleRow.swift
//  Quitlet
//
//  Created by Александр Андреев on 29.08.2024.
//

import Foundation
import SwiftUI

import SwiftUI

struct ModuleRow: View {
    let module: FlashCardModule

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(module.name)
                    .font(.headline)
                Text("\(module.flashCards.count) cards - Best Progress: \(Int(module.bestCompletionPercentage))%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
}


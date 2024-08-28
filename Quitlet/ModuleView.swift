//
//  ModuleView.swift
//  Quitlet
//
//  Created by Александр Андреев on 29.08.2024.
//

import Foundation
import SwiftUI

struct ModuleView: View {
    let module: FlashCardModule

    var body: some View {
        VStack(alignment: .leading) {
            Text(module.name)
                .font(.headline)
                .foregroundColor(.primary)
            Text("\(module.totalCardCount) cards - Best Progress: \(Int(module.bestCompletionPercentage))%")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 3)
        .frame(maxWidth: .infinity) // Занимает всю доступную ширину
    }
}






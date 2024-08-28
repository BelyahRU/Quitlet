//
//  ModuleView.swift
//  Quitlet
//
//  Created by Александр Андреев on 29.08.2024.
//

import Foundation
import SwiftUI

import SwiftUI

struct ModuleView: View {
    let module: FlashCardModule

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(module.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("\(module.flashCards.count) cards")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(15)
                .shadow(radius: 10)
        )
        .frame(width: UIScreen.main.bounds.width - 32, height: 150) // Make the module occupy almost full width and fixed height
    }
}


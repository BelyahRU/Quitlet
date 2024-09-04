

import Foundation
import SwiftUI

struct ModuleView: View {
    let module: FlashCardModule

    var body: some View {
        ZStack {
            // Фон
            if module.bestCompletionPercentage == 100 {
                Color.green
                    .edgesIgnoringSafeArea(.all)
            } else {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(module.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)

                Text("\(module.flashCards.count) cards")
                    .font(.subheadline)
                    .foregroundColor(.white)

                HStack {
                    Text("Best: \(Int(module.bestCompletionPercentage))%")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.trailing, 8)
                }
                
            }
            .padding()
        }
        .cornerRadius(15)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}

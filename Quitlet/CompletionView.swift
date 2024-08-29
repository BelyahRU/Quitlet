//
//  CompletionView.swift
//  Quitlet
//
//  Created by Александр Андреев on 29.08.2024.
//

import Foundation
import SwiftUI

struct CompletionView: View {
    var completionPercentage: Double
    var onReplay: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            if completionPercentage == 100 {
                Text("Congratulations!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            } else {
                Text("Good effort!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }

            Text("Your completion percentage: \(Int(completionPercentage))%")
                .font(.title)
                .padding()

            Button(action: onReplay) {
                Text("Replay Module")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

//
//  File.swift
//  Quitlet
//
//  Created by Александр Андреев on 29.08.2024.
//

import Foundation
import SwiftUI

struct FlashCardView: View {
    let card: FlashCard
    @Binding var showTranslation: Bool
    @Binding var offset: CGSize
    @Binding var flashColor: Color
    @Binding var hideText: Bool
    var onSwipe: (Bool) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(flashColor)
                .shadow(radius: 5)
                .animation(.easeInOut(duration: 0.3), value: flashColor)

            VStack {
                if !hideText {
                    if showTranslation {
                        Text(card.answer)
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    } else {
                        Text(card.question)
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
        }
        .frame(height: 200)
        .padding()
        .offset(x: offset.width * 1.2, y: 0)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        let isCorrect = offset.width > 0
                        onSwipe(isCorrect)
                    } else {
                        // Возвращаем карточку в исходное положение при небольшом свайпе
                        withAnimation {
                            offset = .zero
                        }
                    }
                }
        )
        .animation(.spring(), value: offset)
    }
}

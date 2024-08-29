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

    @State private var isFlipped: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(isFlipped ? Color.gray : flashColor)
                .shadow(radius: 5)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .animation(.easeInOut(duration: 0.6), value: isFlipped)

            VStack {
                if !hideText {
                    if isFlipped {
                        Text(card.answer)
                            .font(.largeTitle)
                            .foregroundColor(.white) // Белый цвет текста для перевернутой карточки
                            .transition(.opacity) // Плавное появление текста
                    } else {
                        Text(card.question)
                            .font(.largeTitle)
                            .foregroundColor(.black) // Черный цвет текста для лицевой стороны карточки
                            .transition(.opacity) // Плавное появление текста
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
        .onTapGesture {
            // Переключение переворота карточки
            withAnimation {
                isFlipped.toggle()
            }
        }
        .animation(.spring(), value: offset)
    }
}


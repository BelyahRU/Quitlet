//
//  AddCardView.swift
//  Quitlet
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import SwiftUI
import SwiftUI

struct AddCardView: View {
    @Binding var module: FlashCardModule
    @Environment(\.presentationMode) var presentationMode
    
    @State private var word: String = ""
    @State private var translation: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Card")) {
                    TextField("Word", text: $word)
                    TextField("Translation", text: $translation)
                }
                
                Button(action: addCard) {
                    Text("Add Card")
                }
                .disabled(word.isEmpty || translation.isEmpty)
            }
            .navigationBarTitle("Add Card", displayMode: .inline)
        }
    }
    
    func addCard() {
        let newCard = FlashCard(question: word, answer: translation)
        module.flashCards.append(newCard)
        presentationMode.wrappedValue.dismiss() // Закрываем модальное окно после добавления карточки
    }
}



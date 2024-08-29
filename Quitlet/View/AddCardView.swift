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
    @State private var question: String = ""
    @State private var answer: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add New Card")) {
                    TextField("Question", text: $question)
                    TextField("Answer", text: $answer)
                }
                Button("Save") {
                    if !question.isEmpty && !answer.isEmpty {
                        let newCard = FlashCard(question: question, answer: answer)
                        module.flashCards.append(newCard)
                        question = ""
                        answer = ""
                    }
                }
            }
            .navigationTitle("Add Card")
            .navigationBarItems(trailing: Button("Done") {
                // This will close the sheet
            })
        }
    }
}



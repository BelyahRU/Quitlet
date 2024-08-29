//
//  AddCardView.swift
//  Quitlet
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
import SwiftUI

struct AddCardView: View {
    @Binding var module: FlashCardModule
    @Environment(\.presentationMode) var presentationMode
    
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
                        presentationMode.wrappedValue.dismiss()  // Close the view after saving
                    }
                }
                .disabled(question.isEmpty || answer.isEmpty)  // Disable button if fields are empty
            }
            .navigationTitle("Add Card")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()  // Close the view
            })
        }
    }
}




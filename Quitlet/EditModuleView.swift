//
//  EditModuleView.swift
//  Quitlet
//
//  Created by Александр Андреев on 29.08.2024.
//

import Foundation
import SwiftUI

struct EditModuleView: View {
    @Binding var module: FlashCardModule
    @Environment(\.presentationMode) var presentationMode
    @State private var newQuestion = ""
    @State private var newAnswer = ""
    @State private var showingDeleteConfirmation = false
    @State private var selectedCardToDelete: FlashCard? = nil

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Cards")) {
                        ForEach(module.flashCards) { card in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(card.question)
                                    Text(card.answer)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button(action: {
                                    selectedCardToDelete = card
                                    showingDeleteConfirmation = true
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())

                Section {
                    TextField("Question", text: $newQuestion)
                    TextField("Answer", text: $newAnswer)
                    Button(action: addCard) {
                        Text("Add Card")
                    }
                }
                .padding()
            }
            .navigationTitle("Edit Module")
            .navigationBarItems(trailing: HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            })
            .alert(isPresented: $showingDeleteConfirmation) {
                Alert(
                    title: Text("Delete Card"),
                    message: Text("Are you sure you want to delete this card?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let card = selectedCardToDelete {
                            deleteCard(card)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    private func addCard() {
        let newCard = FlashCard(question: newQuestion, answer: newAnswer)
        module.flashCards.append(newCard)
        newQuestion = ""
        newAnswer = ""
    }

    private func deleteCard(_ card: FlashCard) {
        module.flashCards.removeAll { $0.id == card.id }
    }
}


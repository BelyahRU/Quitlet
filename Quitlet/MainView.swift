//
//  ContentView.swift
//  Quitlet
//
//  Created by Александр Андреев on 26.08.2024.
//

import SwiftUI

struct MainView: View {
    @State private var modules: [FlashCardModule] = [
        FlashCardModule(name: "Fruits", flashCards: [
            FlashCard(question: "Apple", answer: "Яблоко"),
            FlashCard(question: "Banana", answer: "Банан"),
            FlashCard(question: "Fruit", answer: "Банан"),
            FlashCard(question: "Red", answer: "Банан"),
            FlashCard(question: "Blue", answer: "Банан"),
            FlashCard(question: "White", answer: "Банан"),
        ]),
        FlashCardModule(name: "Colors", flashCards: [
            FlashCard(question: "Red", answer: "Красный"),
            FlashCard(question: "Blue", answer: "Синий")
        ])
    ]
    
    @State private var showingAddModuleView = false

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach($modules) { $module in
                        NavigationLink(destination: FlashCardsView(module: $module)) {
                            ModuleView(module: module)
                        }
                        .buttonStyle(PlainButtonStyle()) // Убирает эффект выделения нажатия
                    }
                }
                .padding()
                .frame(maxWidth: .infinity) // Занимает всю доступную ширину
            }
            .navigationTitle("Modules")
            .navigationBarItems(trailing: Button(action: {
                showingAddModuleView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddModuleView) {
                AddModuleView(modules: $modules)
            }
        }
    }
}





#Preview {
    MainView()
}

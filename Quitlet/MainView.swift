//
//  ContentView.swift
//  Quitlet
//
//  Created by Александр Андреев on 26.08.2024.
//

import SwiftUI
import SwiftUI

struct FlashCardModule: Identifiable {
    let id = UUID()
    let name: String
    var flashCards: [FlashCard]
}



import SwiftUI

import SwiftUI

import SwiftUI

struct MainView: View {
    @State private var modules: [FlashCardModule] = [
        FlashCardModule(name: "Fruits", flashCards: [
            FlashCard(question: "Apple", answer: "Яблоко"),
            FlashCard(question: "Banana", answer: "Банан")
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
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach($modules) { $module in
                        NavigationLink(destination: FlashCardsView(module: $module)) {
                            ModuleView(module: module)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
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

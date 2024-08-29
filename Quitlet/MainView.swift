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
                FlashCard(question: "Orange", answer: "Апельсин"),
                FlashCard(question: "Grapes", answer: "Виноград"),
                FlashCard(question: "Peach", answer: "Персик"),
                FlashCard(question: "Pineapple", answer: "Ананас")
            ]),
            FlashCardModule(name: "Colors", flashCards: [
                FlashCard(question: "Red", answer: "Красный"),
                FlashCard(question: "Blue", answer: "Синий"),
                FlashCard(question: "Green", answer: "Зеленый"),
                FlashCard(question: "Yellow", answer: "Желтый"),
                FlashCard(question: "Black", answer: "Черный"),
                FlashCard(question: "White", answer: "Белый")
            ]),
            FlashCardModule(name: "Animals", flashCards: [
                FlashCard(question: "Dog", answer: "Собака"),
                FlashCard(question: "Cat", answer: "Кошка"),
                FlashCard(question: "Horse", answer: "Лошадь"),
                FlashCard(question: "Elephant", answer: "Слон"),
                FlashCard(question: "Tiger", answer: "Тигр"),
                FlashCard(question: "Giraffe", answer: "Жираф")
            ]),
            FlashCardModule(name: "Countries", flashCards: [
                FlashCard(question: "USA", answer: "США"),
                FlashCard(question: "France", answer: "Франция"),
                FlashCard(question: "Germany", answer: "Германия"),
                FlashCard(question: "Japan", answer: "Япония"),
                FlashCard(question: "Italy", answer: "Италия"),
                FlashCard(question: "Brazil", answer: "Бразилия")
            ]),
            FlashCardModule(name: "Food", flashCards: [
                FlashCard(question: "Pizza", answer: "Пицца"),
                FlashCard(question: "Burger", answer: "Бургер"),
                FlashCard(question: "Pasta", answer: "Паста"),
                FlashCard(question: "Sushi", answer: "Суши"),
                FlashCard(question: "Salad", answer: "Салат"),
                FlashCard(question: "Soup", answer: "Суп")
            ]),
            FlashCardModule(name: "Instruments", flashCards: [
                FlashCard(question: "Guitar", answer: "Гитара"),
                FlashCard(question: "Piano", answer: "Пианино"),
                FlashCard(question: "Drums", answer: "Барабаны"),
                FlashCard(question: "Violin", answer: "Скрипка"),
                FlashCard(question: "Trumpet", answer: "Труба"),
                FlashCard(question: "Saxophone", answer: "Саксофон")
            ])
        ]
    
    @State private var showingAddModuleView = false

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
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

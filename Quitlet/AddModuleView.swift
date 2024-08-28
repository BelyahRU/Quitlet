//
//  AddModuleView.swift
//  Quitlet
//
//  Created by Александр Андреев on 29.08.2024.
//

import Foundation
import SwiftUI

struct AddModuleView: View {
    @Binding var modules: [FlashCardModule]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var moduleName: String = ""
    @State private var word: String = ""
    @State private var translation: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Module")) {
                    TextField("Module Name", text: $moduleName)
                }
                
                Section(header: Text("New Card")) {
                    TextField("Word", text: $word)
                    TextField("Translation", text: $translation)
                }
                
                Button(action: addModule) {
                    Text("Add Module")
                }
                .disabled(moduleName.isEmpty || word.isEmpty || translation.isEmpty)
            }
            .navigationBarTitle("Add Module")
            .navigationBarItems(trailing: Button("Done") {
                addModule()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func addModule() {
        let newCard = FlashCard(question: word, answer: translation)
        let newModule = FlashCardModule(name: moduleName, flashCards: [newCard])
        modules.append(newModule)
    }
}

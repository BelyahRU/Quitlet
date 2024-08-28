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
    @State private var moduleName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Module Information")) {
                    TextField("Module Name", text: $moduleName)
                }
                
                Button(action: addModule) {
                    Text("Add Module")
                }
                .disabled(moduleName.isEmpty)
            }
            .navigationTitle("Add Module")
        }
    }

    func addModule() {
        let newModule = FlashCardModule(name: moduleName, flashCards: [])
        modules.append(newModule)
    }
}

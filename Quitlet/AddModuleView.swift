import SwiftUI

struct AddModuleView: View {
    @Binding var modules: [FlashCardModule]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var moduleName: String = ""
    @State private var question: String = ""
    @State private var answer: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Module")) {
                    TextField("Module Name", text: $moduleName)
                }
                
                Section(header: Text("New Card")) {
                    TextField("Question", text: $question)
                    TextField("Answer", text: $answer)
                }
                
                Button(action: addModule) {
                    Text("Add Module")
                }
                .disabled(moduleName.isEmpty || question.isEmpty || answer.isEmpty)
            }
            .navigationBarTitle("Add Module")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addModule() {
        let newCard = FlashCard(question: question, answer: answer)
        let newModule = FlashCardModule(name: moduleName, flashCards: [newCard])
        modules.append(newModule)
        presentationMode.wrappedValue.dismiss() // Закрываем экран и возвращаемся на главный экран
    }
}

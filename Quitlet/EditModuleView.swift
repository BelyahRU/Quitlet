import SwiftUI


struct EditModuleView: View {
    @Binding var module: FlashCardModule
    @Environment(\.presentationMode) var presentationMode // Добавьте Environment для управления модальным окном
    @State private var moduleName: String
    @State private var flashCards: [FlashCard]
    @State private var isShowingAddCardView = false

    init(module: Binding<FlashCardModule>) {
        _module = module
        _moduleName = State(initialValue: module.wrappedValue.name)
        _flashCards = State(initialValue: module.wrappedValue.flashCards)
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Module Name", text: $moduleName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List {
                    ForEach(flashCards) { card in
                        HStack {
                            Text(card.question)
                            Spacer()
                            Text(card.answer)
                        }
                    }
                    .onDelete(perform: deleteCard)
                }

                Button(action: {
                    isShowingAddCardView = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Card")
                    }
                }
                .padding()
                .sheet(isPresented: $isShowingAddCardView) {
                    AddCardView(module: $module) {
                        flashCards = module.flashCards // Update local cards list
                    }
                }

                Spacer()
            }
            .navigationTitle("Edit Module")
            .navigationBarItems(trailing: Button("Save") {
                saveChanges()
                presentationMode.wrappedValue.dismiss() // Свернуть модальное окно после сохранения
            })
        }
    }

    private func saveChanges() {
        module.name = moduleName
        module.flashCards = flashCards
    }

    private func deleteCard(at offsets: IndexSet) {
        flashCards.remove(atOffsets: offsets)
    }
}

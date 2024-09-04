import SwiftUI

struct AddCardView: View {
    @Binding var module: FlashCardModule
    @Environment(\.presentationMode) var presentationMode
    @State private var term: String = ""
    @State private var definition: String = ""
    var onCardAdded: () -> Void // Замыкание для обновления localFlashCards

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Term", text: $term)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Enter Definition", text: $definition)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    addNewCard()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Card")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Add New Card")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func addNewCard() {
        let newCard = FlashCard(question: term, answer: definition)
        module.flashCards.append(newCard)
        onCardAdded() // Вызываем замыкание после добавления новой карточки
    }
}

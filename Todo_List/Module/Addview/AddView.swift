import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel

    // Form State
    @State private var titleText = ""
    @State private var descriptionText = ""
    @State private var selectedType = "Personal"
    @State private var selectedPriority = "Low"

    private let types = ["Personal", "Work", "Study", "Other"]
    private let priorities = ["Low", "Medium", "High"]

    var body: some View {
        Form {
            titleAndDescriptionSection
            typePickerSection
            priorityPickerSection
            saveButtonSection
        }
        .navigationTitle("Add an Item 🖋️")
    }

    // MARK: - Title & Description Section
    private var titleAndDescriptionSection: some View {
        Section(header: Text("Title & Description")) {
            TextField("Enter title...", text: $titleText)
            TextField("Enter description...", text: $descriptionText)
        }
    }

    // MARK: - Type Picker Section
    private var typePickerSection: some View {
        Section(header: Text("Type")) {
            Picker("Select Type", selection: $selectedType) {
                ForEach(types, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }

    // MARK: - Priority Picker Section
    private var priorityPickerSection: some View {
        Section(header: Text("Priority")) {
            Picker("Select Priority", selection: $selectedPriority) {
                ForEach(priorities, id: \.self) { priority in
                    Text(priority)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }

    // MARK: - Save Button Section
    private var saveButtonSection: some View {
        Section {
            Button(action: saveButton) {
                Text("SAVE")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(titleText.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(titleText.isEmpty)
        }
    }

    // MARK: - Save Button Logic
    private func saveButton() {
        listViewModel.addItem(
            title: titleText,
            description: descriptionText,
            type: selectedType,
            priority: selectedPriority
        ) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    NavigationView {
        AddView()
            .environmentObject(ListViewModel())
    }
}

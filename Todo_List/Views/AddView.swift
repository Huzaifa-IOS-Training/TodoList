//
//  AddView.swift
//  Todo_List
//
//  Created by Huzaifa on 26/08/2025.
//

import SwiftUI

struct AddView: View {

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var titleText: String = ""
    @State var descriptionText: String = ""
    @State var selectedType: String = "Personal"
    @State var selectedPriority: String = "Low"

    let types = ["Personal", "Work", "Study", "Other"]
    let priorities = ["Low", "Medium", "High"]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("Enter title...", text: $titleText)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(10)

                TextField("Enter description...", text: $descriptionText)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(10)

                Picker("Select Type", selection: $selectedType) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Picker("Select Priority", selection: $selectedPriority) {
                    ForEach(priorities, id: \.self) { priority in
                        Text(priority)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Button(action: saveButton) {
                    Text("SAVE")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(titleText.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Add an Item 🖋️")
    }

    func saveButton() {
        listViewModel.addItem(
            title: titleText,
            description: descriptionText,
            type: selectedType,
            priority: selectedPriority
        )
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    NavigationView {
        AddView()
            .environmentObject(ListViewModel())
    }
}

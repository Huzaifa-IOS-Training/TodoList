//
//  AddView.swift
//  Todo_List
//
//  Created by Huzaifa on 26/08/2025.
//

import SwiftUI

struct AddView: View {

    @Environment(\.presentationMode) var presentationMode
    
    // access the ListViewModel
    @EnvironmentObject var listViewModel: ListViewModel
    
    // @State Varuable holdes the form data
    @State var titleText: String = ""
    @State var descriptionText: String = ""
    @State var selectedType: String = "Personal"
    @State var selectedPriority: String = "Low"

    let types = ["Personal", "Work", "Study", "Other"]
    let priorities = ["Low", "Medium", "High"]

    var body: some View {
        Form {
            
            // Title & Description View
            Section(header: Text("Title & Description")) {
                TextField("Enter title...", text: $titleText)
                TextField("Enter description...", text: $descriptionText)
            }

            // Type PickerView
            Section(header: Text("Type")) {
                Picker("Select Type", selection: $selectedType) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            // Priority View
            Section(header: Text("Priority")) {
                Picker("Select Priority", selection: $selectedPriority) {
                    ForEach(priorities, id: \.self) { priority in
                        Text(priority)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            // Save Button View
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
        .navigationTitle("Add an Item 🖋️")
    }
    
    // Save Button Logic: call addItem function in listviewmodel and dismiss this current page and go to ListView
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

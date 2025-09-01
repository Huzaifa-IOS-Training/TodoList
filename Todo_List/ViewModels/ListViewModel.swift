//
//  ListViewModel.swift
//  Todo_List
//
//  Created by Huzaifa on 27/08/2025.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }

    let itemsKey: String = "todo_list_items"

    init () {
        getItems()
    }

    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }

        self.items = savedItems
    }

    func deleteItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }

    func addItem(title: String, description: String, type: String, priority: String) {
        let newItem = ItemModel(
            title: title,
            description: description,
            type: type,
            priority: priority,
            isCompleted: false
        )
        items.append(newItem)
    }

    func updateItem(item: ItemModel){
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }

    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}

//
//  ListViewModel.swift
//  Todo_List
//
//  Created by Huzaifa on 27/08/2025.
//

import Foundation



class ListViewModel: ObservableObject { // use ObservableObject to notify the UI
    
    // use @public for automatically refresh the UI when the list is change
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }

    // use for store data in user default
    let itemsKey: String = "todo_list_items"

    // call  when the app start
    init () {
        getItems()
    }

    // get data from userDefault and decode
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }

        self.items = savedItems
    }

    // for delte the item
    func deleteItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }

    // for change the index
    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }

    // add new item
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

    
    //update the item
    func updateItem(item: ItemModel){
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }

    //convert item arry into json and save it into userDefault
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}

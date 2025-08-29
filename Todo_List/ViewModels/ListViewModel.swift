//
//  ListViewModel.swift
//  Todo_List
//
//  Created by Huzaifa on 27/08/2025.
//

import Foundation

class ListViewModel: ObservableObject {
     
    @Published var items: [ItemModel] = []
    
    init () {
        getItems()
    }
    
    func getItems() {
        let newItems =
        [
            ItemModel(title: "This is my first title!", isCompleted: false),
            ItemModel(title: "This is my second title!", isCompleted: true),
            ItemModel(title: "This is my third title!", isCompleted: false),
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel){
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
}

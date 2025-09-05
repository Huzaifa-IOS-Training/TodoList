//
//  ListViewModel.swift
//  Todo_List
//
//  Created by Huzaifa on 27/08/2025.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = []
    
    init() {
        fetchItems()
    }

    // MARK: - Fetch Items
    
    func fetchItems() {
        APIService.shared.fetchItems { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedItems):
                    self?.items = fetchedItems
                case .failure(let error):
                    self?.handleError("Fetch Error", error)
                }
            }
        }
    }

    // MARK: - Add Item
    
    func addItem(
        title: String,
        description: String,
        type: String,
        priority: String,
        onSuccess: @escaping () -> Void = {}
    ) {
        let newItem = ItemModel(
            title: title,
            description: description,
            type: type,
            priority: priority,
            isCompleted: false
        )
        
        APIService.shared.addItem(newItem) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let addedItem):
                    self?.items.append(addedItem)
                    onSuccess()
                case .failure(let error):
                    self?.handleError("Add Error", error)
                }
            }
        }
    }

    // MARK: - Update Item Completion
    
    func updateItem(item: ItemModel) {
        let updatedItem = item.updateCompletion()
        
        APIService.shared.updateItem(updatedItem) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let returnedItem):
                    self?.replaceItem(with: returnedItem)
                case .failure(let error):
                    self?.handleError("Update Error", error)
                }
            }
        }
    }

    // MARK: - Delete Item
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            APIService.shared.deleteItem(item.id) { error in
                if let error = error {
                    self.handleError("Delete Error", error)
                }
            }
        }
        items.remove(atOffsets: offsets)
    }

    // MARK: - Move Item (Local Only)
    
    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }

    // MARK: - Helpers

    private func replaceItem(with updatedItem: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
        }
    }

    private func handleError(_ context: String, _ error: Error) {
        print("❌ \(context): \(error.localizedDescription)")
    }
}

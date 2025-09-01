//
//  ItemModel.swift
//  Todo_List
//
//  Created by Huzaifa on 26/08/2025.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    var id: String
    var title: String
    var description: String
    var type: String
    var priority: String
    var isCompleted: Bool

    init(
        id: String = UUID().uuidString,
        title: String,
        description: String,
        type: String,
        priority: String,
        isCompleted: Bool
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.priority = priority
        self.isCompleted = isCompleted
    }

    func updateCompletion() -> ItemModel {
        return ItemModel(
            id: id,
            title: title,
            description: description,
            type: type,
            priority: priority,
            isCompleted: !isCompleted
        )
    }
}

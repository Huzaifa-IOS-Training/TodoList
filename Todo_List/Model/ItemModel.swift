//
//  ItemModel.swift
//  Todo_List
//
//  Created by Huzaifa on 26/08/2025.
//

import Foundation

// use identifiable to identify according to id and Codable for encode/decode
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

    //update the ItemModel, return new ItemModel because struct is value type 
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

//
//  ItemModel.swift
//  Todo_List
//
//  Created by Huzaifa on 26/08/2025.
//

import Foundation


struct ItemModel: Identifiable {
    var id: String
    var title: String
    var isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool){
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion()->ItemModel{
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}

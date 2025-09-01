//
//  ListRowView.swift
//  Todo_List
//
//  Created by Huzaifa on 26/08/2025.
//

import SwiftUI

struct ListRowView: View {

    let item: ItemModel
    let isExpanded: Bool
    let onToggleCompletion: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                    .foregroundColor(item.isCompleted ? .green : .red)
                    .onTapGesture {
                        onToggleCompletion()
                    }

                Text(item.title)
                    .font(.title2)
                    .bold()

                Spacer()

                Text(item.priority)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(priorityColor())
                    .cornerRadius(6)
            }

            if isExpanded {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Description: \(item.description)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Type: \(item.type)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 5)
                .transition(.opacity)
            }
        }
        .padding(.vertical, 8)
        .animation(.easeInOut, value: isExpanded)
    }

    func priorityColor() -> Color {
        switch item.priority {
        case "High":
            return .red
        case "Medium":
            return .orange
        default:
            return .blue
        }
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    Group {
        ListRowView(
            item: ItemModel(title: "First Title", description: "Description", type: "Work", priority: "High", isCompleted: false),
            isExpanded: true,
            onToggleCompletion: {}
        )

        ListRowView(
            item: ItemModel(title: "Second Title", description: "Another Desc", type: "Personal", priority: "Low", isCompleted: true),
            isExpanded: false,
            onToggleCompletion: {}
        )
    }
    .padding()
}

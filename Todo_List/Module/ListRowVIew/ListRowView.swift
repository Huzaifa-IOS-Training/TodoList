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
            headerRow
            
            if isExpanded {
                expandedDetails
                    .padding(.top, 5)
                    .transition(.opacity)
            }
        }
        .padding(.vertical, 8)
        .animation(.easeInOut, value: isExpanded)
    }

    // MARK: - Header Row (Title, Checkmark, Priority)
    private var headerRow: some View {
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
                .background(priorityColor)
                .cornerRadius(6)
        }
    }

    // MARK: - Expanded View (Description, Type)
    private var expandedDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Description: \(item.description)")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Type: \(item.type)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }

    // MARK: - Priority Color Logic
    private var priorityColor: Color {
        switch item.priority {
        case "High": return .red
        case "Medium": return .orange
        default: return .blue
        }
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    Group {
        ListRowView(
            item: ItemModel(
                title: "Buy Groceries",
                description: "Milk, Eggs, Bread, Butter",
                type: "Personal",
                priority: "High",
                isCompleted: false
            ),
            isExpanded: true,
            onToggleCompletion: {}
        )

        ListRowView(
            item: ItemModel(
                title: "Read Book",
                description: "Finish Chapter 5 of SwiftUI Essentials",
                type: "Study",
                priority: "Low",
                isCompleted: true
            ),
            isExpanded: false,
            onToggleCompletion: {}
        )
    }
    .padding()
}

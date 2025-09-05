import SwiftUI

struct ListView: View {
    
    // Access shared view model
    @EnvironmentObject var listViewModel: ListViewModel
    
    // Track expanded item IDs
    @State private var expandedItemIDs: Set<String> = []

    var body: some View {
        List {
            taskRows
        }
        .listStyle(.plain)
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView().environmentObject(listViewModel))
        )
    }


    private var taskRows: some View {
        ForEach(listViewModel.items) { item in
            ListRowView(
                item: item,
                isExpanded: expandedItemIDs.contains(item.id),
                onToggleCompletion: {
                    listViewModel.updateItem(item: item)
                }
            )
            .onTapGesture {
                toggleExpanded(for: item.id)
            }
        }
        .onDelete(perform: listViewModel.deleteItem)
        .onMove(perform: listViewModel.moveItem)
    }

    
    private func toggleExpanded(for id: String) {
        withAnimation(.linear) {
            if expandedItemIDs.contains(id) {
                expandedItemIDs.remove(id)
            } else {
                expandedItemIDs.insert(id)
            }
        }
    }
}

#Preview {
    NavigationView {
        
        // Provide ViewModel (ListViewModel) to ListView via .environmentObject
        ListView()
            .environmentObject(ListViewModel())
    }
}

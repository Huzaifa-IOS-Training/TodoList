import SwiftUI

struct ListView: View {

    // EnvironmentObject Access the ListViewModel
    @EnvironmentObject var listViewModel: ListViewModel
    
    // Track which row is expand
    @State private var expandedItemIDs: Set<String> = []

    var body: some View {
        List {
            ForEach(listViewModel.items) { item in
                ListRowView(
                    item: item,
                    isExpanded: expandedItemIDs.contains(item.id),
                    
                    // onToggleCompletion change the task complete/incomplete
                    onToggleCompletion: {
                        listViewModel.updateItem(item: item)
                    }
                )
                
                // onclick on row it expand/collapse
                .onTapGesture {
                    withAnimation(.linear) {
                        if expandedItemIDs.contains(item.id) {
                            expandedItemIDs.remove(item.id)
                        } else {
                            expandedItemIDs.insert(item.id)
                        }
                    }
                }
            }
            
            // Top Buttons
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView().environmentObject(listViewModel))
        )
    }
}

#Preview {
    NavigationView {
        
        // Provide ViewModel (ListViewModel) to ListView via .environmentObject
        ListView()
            .environmentObject(ListViewModel())
    }
}

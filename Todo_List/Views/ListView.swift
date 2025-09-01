import SwiftUI

struct ListView: View {

    @EnvironmentObject var listViewModel: ListViewModel
    @State private var expandedItemIDs: Set<String> = []

    var body: some View {
        List {
            ForEach(listViewModel.items) { item in
                ListRowView(
                    item: item,
                    isExpanded: expandedItemIDs.contains(item.id),
                    onToggleCompletion: {
                        listViewModel.updateItem(item: item)
                    }
                )
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
        ListView()
            .environmentObject(ListViewModel())
    }
}

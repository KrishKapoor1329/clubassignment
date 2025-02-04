import SwiftUI

struct ContentView: View {
    @State var lists: [DemoList] = []
    @State var showAlert = false
    @State var newListName = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(lists.indices, id: \ .self) { index in
                    NavigationLink(lists[index].name, destination: {
                        ListView(list: $lists[index])
                    })
                }
            }
            .navigationTitle("StudyBuddy")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("New List", isPresented: $showAlert) {
                TextField("Enter list name", text: $newListName)
                Button("Add") {
                    if !newListName.isEmpty {
                        lists.append(DemoList(name: newListName, items: []))
                        newListName = ""
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

struct ListView: View {
    @Binding var list: DemoList
    @State private var showItemAlert = false
    @State private var newItemName: String = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(list.items.indices, id: \ .self) { index in
                    Text(list.items[index].name)
                }
            }
            .navigationTitle(list.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showItemAlert = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("New Item", isPresented: $showItemAlert) {
                TextField("Enter item name", text: $newItemName)
                Button("Add") {
                    if !newItemName.isEmpty {
                        list.items.append(DemoItem(name: newItemName))
                        newItemName = ""
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

class DemoList: ObservableObject {
    var name: String
    var items: [DemoItem]
    
    init(name: String, items: [DemoItem]) {
        self.name = name
        self.items = items
    }
}

class DemoItem: ObservableObject {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

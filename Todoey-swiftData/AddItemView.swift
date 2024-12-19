import SwiftUI

struct AddItemView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var done = false
    
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("项目名称", text: $title)
            }
            .navigationTitle("添加新项目")
            .navigationBarItems(
                leading: Button("取消") {
                    dismiss()
                },
                trailing: Button("添加") {
                    let newItem = Item(title: title, done: done)
                    context.insert(newItem)
                    do {
                        try context.save()  // 保存上下文的所有更改
                        dismiss()
                    } catch {
                        print("保存数据时出错: \(error)")
                    }
                }
                    .disabled(title.isEmpty)
            )
        }
    }
}


#Preview {
    AddItemView()
        .modelContainer(for: Item.self, inMemory: true)
}


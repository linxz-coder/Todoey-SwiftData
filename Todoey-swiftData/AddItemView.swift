import SwiftUI

struct AddItemView: View {
    @Binding var isPresented: Bool
    @State private var title = ""
    @State private var done = false
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationView {
            Form {
                TextField("项目名称", text: $title)
            }
            .navigationTitle("添加新项目")
            .navigationBarItems(
                leading: Button("取消") {
                    isPresented = false
                },
                trailing: Button("添加") {
                    let newItem = Item(title: title, done: done)
                    context.insert(newItem)
                    do {
                        try context.save()  // 保存上下文的所有更改
                        isPresented = false
                    } catch {
                        print("保存数据时出错: \(error)")
                    }
                }
                    .disabled(title.isEmpty)
            )
        }
    }
}


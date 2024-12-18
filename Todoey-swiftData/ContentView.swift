import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Item.title) private var items: [Item]
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("待办清单")
                        .font(.largeTitle)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Button {
                        print("Button tapped")
                        showingAddSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 22))
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.top, 60)
                .padding(.bottom, 10)
                
                // 列表内容
                List {
                    ForEach(items) { item in
                        Toggle(item.title, isOn: Binding(
                            //获取当前.done的值
                            get: { item.done },
                            //.done的值变化时，操作数据库
                            set: { newValue in
                                item.done = newValue
                                do {
                                    try context.save()
                                } catch {
                                    print("保存数据时出错: \(error)")
                                }
                                
                            }
                        ))
                        .toggleStyle(CheckboxToggleStyle())
                        .frame(height: 60)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                context.delete(item)
                                do {
                                    try context.save()  // 提交更改
                                } catch {
                                    print("删除项目时出错: \(error)")
                                }
                            } label: {
                                Label("删除", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)  // 隐藏默认导航栏
        }
        .sheet(isPresented: $showingAddSheet) {
            AddItemView(isPresented: $showingAddSheet)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self)
}


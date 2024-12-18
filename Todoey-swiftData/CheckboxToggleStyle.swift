import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    @State private var isPressed = false  // 添加状态来跟踪点击
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            
            if configuration.isOn {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
                    .font(.system(size: 20))
            }
        }
        .frame(height: 60)
        .background(isPressed ? Color.gray.opacity(0.2) : Color.clear)  // 点击时显示灰色背景
        .onTapGesture {
            // 点击时的动画效果
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
                
                // 0.1秒后恢复
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        isPressed = false
                    }
                }
                
                configuration.isOn.toggle()
            }
        }
    }
}


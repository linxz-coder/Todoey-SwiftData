import SwiftData

@Model
class Item{
    var title: String
    var done: Bool
    
        init(
            title: String,
            done: Bool
        ){
            self.title = title
            self.done = done
        }
}

//
//  Todoey_swiftDataApp.swift
//  Todoey-swiftData
//
//  Created by 林晓中 on 2024/12/18.
//

import SwiftUI

@main
struct Todoey_swiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
    
    init(){
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}

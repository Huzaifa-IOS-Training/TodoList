//
//  Todo_ListApp.swift
//  Todo_List
//
//  Created by Huzaifa on 26/08/2025.
//

import SwiftUI

@main
struct Todo_ListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}

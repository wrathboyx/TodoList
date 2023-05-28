//
//  TodoListApp.swift
//  TodoList
//
//  Created by Bayu Faqih on 27/05/23.
//

import SwiftUI

/*
 MVVM ARCHITECTURE
 
 Model - data point
 View - UI
 ViewModel - managees Models for View
 
 */

@main
struct TodoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            // For iPad
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}

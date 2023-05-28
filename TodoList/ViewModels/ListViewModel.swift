//
//  ListViewModel.swift
//  TodoList
//
//  Created by Bayu Faqih on 28/05/23.
//

import Foundation

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 
 */

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        // Anytime the data change with items array this function will get called
        didSet {
            saveItems()
        }
    }
    
    let itemKeys: String = "item_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let dataUser = UserDefaults.standard.data(forKey: itemKeys), // Checking data that we have data ... if true run this code, and if false return
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: dataUser) // Checking data that we can convert that data into items
        else { return }
        
        self.items = savedItems
        
    }
    
    // MARK: ALL LOGIC IS DOWN HERE
    
    // MARK: FUNCTION DELETE
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    // MARK: FUNCTION MOVE
    func moveItems(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    // MARK: FUNCTION ADD
    func addItems(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    // MARK: FUNCTION UPDATE
    func updateItems(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    // MARK: FUNCTION SAVE
    func saveItems() {
        // encode data with codable at ItemModel
        if let encodeData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodeData, forKey: itemKeys)
        }
    }
}

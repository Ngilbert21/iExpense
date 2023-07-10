//
//  ContentView.swift
//  iExpense
//
//  Created by Nicholas Gilbert on 6/29/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        
        NavigationView {
            List {
                Section("Personal costs") {
                    ForEach(expenses.items.filter {$0.type == "Personal"}) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .indigo : .red)
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section("Business") {
                    ForEach(expenses.items.filter{$0.type == "Business"}) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .indigo : .red)
                        }
                    }.onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.items.filter{$0.type == "Personal"})
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.items.filter{$0.type == "Business"})
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

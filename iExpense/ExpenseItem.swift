//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Nicholas Gilbert on 7/7/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

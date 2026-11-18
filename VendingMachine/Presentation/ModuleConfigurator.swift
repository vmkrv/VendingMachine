//
//  ModuleConfigurator.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 15.11.2026.
//

import Foundation

struct ModuleConfigurator {
    static func configureViewModel(with balance: Int) -> ViewModel {
        let vendingMachine = VendingMachine()
        let store = Store(vendingMachine: vendingMachine)
        let buyer = Buyer(store: store, balance: balance)
        return ViewModel(buyer: buyer)
    }
}

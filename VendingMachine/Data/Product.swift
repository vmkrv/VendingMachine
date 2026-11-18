//
//  Product.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 13.11.2026.
//

struct Product {
    let name: String
    let price: Int
    var count: Int
}

extension Product {
    func initWithInitialQuantityOne() -> Self {
        Product(name: name, price: price, count: 1)
    }
}

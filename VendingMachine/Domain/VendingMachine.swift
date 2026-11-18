//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 13.11.2026.
//

class VendingMachine {
    private var products = [
        Product(name: "Сникерс", price: 100, count: 3),
        Product(name: "Вода", price: 50, count: 3),
        Product(name: "Конфета", price: 10, count: 3)
    ]

    func getProduct(name: String, balance: inout Int) throws -> Product {
        guard
            let index = products.firstIndex(where: { $0.name == name })
        else {
            throw VendingError.invalidSelection
        }
        let product = products[index]

        if product.count == 0 && product.price > balance {
            throw VendingError.multiple(
                [
                    VendingError.outOfStock,
                    VendingError.insuficientFunds(amount: product.price - balance)
                ]
            )
        }

        guard product.count > 0 else {
            throw VendingError.outOfStock
        }

        guard product.price <= balance else {
            throw VendingError.insuficientFunds(amount: product.price - balance)
        }

        balance -= product.price

        var newItem = product
        newItem.count -= 1
        products[index] = newItem

        return newItem
    }

    func returnProduct(name: String, balance: inout Int) throws -> Product  {
        guard
            let index = products.firstIndex(where: { $0.name == name })
        else {
            throw VendingError.invalidSelection
        }
        let product = products[index]
        balance += product.price

        var newItem = product
        newItem.count += 1
        products[index] = newItem

        return product
    }

    func listAllCurrentProducts() -> [Product] {
        products
    }
}

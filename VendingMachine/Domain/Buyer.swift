//
//  Buyer.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 15.11.2026.
//

class Buyer {
    private var store = Store()
    private var myBalance: Int
    private var purchasedItems = [Product]()

    init(store: Store = Store(), balance: Int) {
        self.store = store
        self.myBalance = balance
    }

    func buySnack(name: String) -> Buyer.ReturnParams {
        let result = store.getSnack(name: name, balance: &myBalance)
        let purchaseMessage: String
        switch result {
        case let .success(product, _):
            addProductToCart(product)
            purchaseMessage = "Вы купили \(product.name)"
        case let .failure(message):
            purchaseMessage = "К сожалению \(message)"
        }
        return Buyer.ReturnParams(
            purchaseMessage: purchaseMessage,
            buyerBalance: myBalance,
            existingProducts: store.listAllCurrentProducts(),
            cartProducts: purchasedItems
        )
    }

    func returnSnack(name: String) -> Buyer.ReturnParams {
        guard
            purchasedItems.map(\.name).contains(name)
        else {
            return Buyer.ReturnParams(
                purchaseMessage: "Вы не можете вернуть товар который ещё не купили",
                buyerBalance: myBalance,
                existingProducts: store.listAllCurrentProducts(),
                cartProducts: purchasedItems
            )
        }
        let result = store.returnSnack(name: name, balance: &myBalance)
        let purchaseMessage: String
        switch result {
        case let .success(product, message):
            removeProductFromCart(product)
            purchaseMessage = message ?? ""
        case let .failure(message):
            purchaseMessage = "К сожалению \(message)"
        }
        return Buyer.ReturnParams(
            purchaseMessage: purchaseMessage,
            buyerBalance: myBalance,
            existingProducts: store.listAllCurrentProducts(),
            cartProducts: purchasedItems
        )
    }

    func listAllCurrentProducts() -> [Product] {
        store.listAllCurrentProducts()
    }

    private func addProductToCart(_ product: Product) {
        guard
            let index = purchasedItems.firstIndex(where: { $0.name == product.name })
        else {
            // нет продуктов этого типа
            purchasedItems.append(product.initWithInitialQuantityOne())
            return
        }
        var existingProduct = purchasedItems[index]
        existingProduct.count += 1
        purchasedItems[index] = existingProduct
    }

    private func removeProductFromCart(_ product: Product) {
        guard
            let index = purchasedItems.firstIndex(where: { $0.name == product.name })
        else {
            // нет продуктов этого типа
            return
        }
        var existingProduct = purchasedItems[index]
        existingProduct.count -= 1
        guard existingProduct.count == 0 else {
            purchasedItems[index] = existingProduct
            return
        }
        purchasedItems.remove(at: index)
    }
}

extension Buyer {
    struct ReturnParams {
        let purchaseMessage: String
        let buyerBalance: Int
        let existingProducts: [Product]
        let cartProducts: [Product]
    }
}

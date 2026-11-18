//
//  ViewModel.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 13.11.2026.
//

import Foundation

@Observable
class ViewModel {
    private var buyer: Buyer

    var buyMessage = " "
    var buyerBalance: Int = 0
    var existingProducts: [Product] = []
    var cartProducts: [Product] = []

    init() {
        self.buyMessage = " "
        let balance = 150
        self.buyer = Buyer(balance: balance)
        self.buyerBalance = balance
        self.existingProducts = buyer.listAllCurrentProducts()
    }

    func buyProduct(_ product: Product) {
        let result = buyer.buySnack(name: product.name)
        buyMessage = result.purchaseMessage
        existingProducts = result.existingProducts
        buyerBalance = result.buyerBalance
        cartProducts = result.cartProducts
    }

    func returnProduct(_ product: Product) {
        let result = buyer.returnSnack(name: product.name)
        buyMessage = result.purchaseMessage
        existingProducts = result.existingProducts
        buyerBalance = result.buyerBalance
        cartProducts = result.cartProducts
    }
}

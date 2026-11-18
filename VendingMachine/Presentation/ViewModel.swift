//
//  ViewModel.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 13.11.2026.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    private let buyer: Buyer

    var buyMessage = " "
    var buyerBalance: Int = 0
    var existingProducts: [Product] = []
    var cartProducts: [Product] = []

    init(buyer: Buyer) {
        self.buyMessage = " "
        self.buyer = buyer
        Task {
            self.buyerBalance = await buyer.getBalance()
            self.existingProducts = await buyer.listAllCurrentProducts()
        }
    }

    func buyProduct(_ product: Product) {
        Task {
            let result = await buyer.buySnack(name: product.name)
            buyMessage = result.purchaseMessage
            existingProducts = result.existingProducts
            buyerBalance = result.buyerBalance
            cartProducts = result.cartProducts
        }
    }

    func returnProduct(_ product: Product) {
        Task {
            let result = await buyer.returnSnack(name: product.name)
            buyMessage = result.purchaseMessage
            existingProducts = result.existingProducts
            buyerBalance = result.buyerBalance
            cartProducts = result.cartProducts
        }
    }
}

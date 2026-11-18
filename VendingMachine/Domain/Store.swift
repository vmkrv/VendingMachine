//
//  Store.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 15.11.2026.
//

class Store {
    enum Result {
        case success(Product, String?)
        case failure(String)
    }

    private let vendingMachine: VendingMachine

    init(vendingMachine: VendingMachine) {
        self.vendingMachine = vendingMachine
    }

    func getSnack(name: String, balance: Int) async -> Result {
        do {
            let product = try await vendingMachine.getProduct(name: name, balance: balance)
            return .success(product, nil)
        } catch VendingError.invalidSelection {
            return .failure(VendingError.invalidSelection.description)
        } catch VendingError.insuficientFunds(let amount) {
            return .failure(VendingError.insuficientFunds(amount: amount).description)
        } catch VendingError.outOfStock {
            return .failure(VendingError.outOfStock.description)
        } catch VendingError.multiple(let errors) {
            return .failure(VendingError.multiple(errors).description)
        } catch {
            return .failure(VendingError.somethingGoesWrong.description)
        }
    }

    func returnSnack(name: String, balance: Int) async -> Result {
        do {
            let product = try await vendingMachine.returnProduct(name: name, balance: balance)
            return .success(product, "Вы вернули \(product.name)")
        } catch  {
            return .failure(VendingError.invalidSelection.description)
        }
    }

    func listAllCurrentProducts() async -> [Product] {
        await vendingMachine.listAllCurrentProducts()
    }
}

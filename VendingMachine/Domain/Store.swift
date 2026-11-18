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

    private var vendingMachine = VendingMachine()

    func getSnack(name: String, balance: inout Int) -> Result {
        do {
            let product = try vendingMachine.getProduct(name: name, balance: &balance)
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

    func returnSnack(name: String, balance: inout Int) -> Result {
        do {
            let product = try vendingMachine.returnProduct(name: name, balance: &balance)
            return .success(product, "Вы вернули \(product.name)")
        } catch  {
            return .failure(VendingError.invalidSelection.description)
        }
    }

    func listAllCurrentProducts() -> [Product] {
        vendingMachine.listAllCurrentProducts()
    }
}

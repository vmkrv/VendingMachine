//
//  VendingError.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 13.11.2026.
//

enum VendingError: Error {
    case invalidSelection
    case insuficientFunds(amount: Int)
    case outOfStock
    case multiple([VendingError])
    case somethingGoesWrong

    var description: String {
        switch self {
        case .invalidSelection:
            return "ошибка выбора"
        case let .insuficientFunds(amount):
            return "не хватает \(amount)₽"
        case .outOfStock:
            return "закончился товар"
        case let .multiple(errors):
            var messages = [String]()
            errors.forEach { error in
                messages.append(error.description)
            }
            return messages.joined(separator: " и ")
        case .somethingGoesWrong:
            return "Неожиданная ошибка"
        }
    }
}

//
//  ProductCardView.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 13.11.2026.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product

    var onIncrement: (() -> Void)?
    var onDecrement: (() -> Void)?

    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            Text(product.name)
                .font(.title3)
                .padding(.trailing, 5)
            Text("**\(product.price)₽**")
                .font(.title3)
                .padding(.trailing, 5)
            Text("\(product.count) шт.")
                .font(.title3)
                .padding(.trailing, 5)
            Spacer()
            Stepper(
                "",
                onIncrement: onIncrement,
                onDecrement: onDecrement
            )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

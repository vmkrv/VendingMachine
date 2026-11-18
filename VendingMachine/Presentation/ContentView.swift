//
//  ContentView.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 13.11.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: .zero) {
                    HStack(spacing: .zero) {
                        Text(viewModel.buyMessage)
                            .font(.headline)
                            .foregroundStyle(.indigo)
                            .frame(alignment: .leading)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Text("Баланс: **\(viewModel.buyerBalance)₽**")
                        .font(.headline)
                        .foregroundStyle(.green)
                        .frame(alignment: .leading)
                        .padding(.leading, 20)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: .zero) {
                    ForEach(viewModel.existingProducts, id: \.name) { product in
                        ProductCardView(
                            product: product,
                            onIncrement: {
                                viewModel.buyProduct(product)
                            },
                            onDecrement: {
                                viewModel.returnProduct(product)
                            }
                        )
                    }
                }
                if !viewModel.cartProducts.isEmpty {
                    Divider()
                    VStack(alignment: .leading, spacing: .zero) {
                        Text("Куплено:")
                            .font(.headline)
                            .frame(alignment: .leading)
                            .padding(.leading, 20)
                        ForEach(viewModel.cartProducts, id: \.name) { product in
                            CartCardView(product: product)
                        }
                    }
                }
            }
            .padding(.top, 100)
        }
    }
}

#Preview {
    ContentView()
}

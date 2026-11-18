//
//  File.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 15.11.2026.
//

import SwiftUI

struct CartCardView: View {
    let product: Product

    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            Text(product.name)
                .font(.title)
                .padding(.trailing, 5)
            Text("\(product.count) шт.")
                .font(.title)
                .padding(.trailing, 5)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

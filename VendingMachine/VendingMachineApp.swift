//
//  VendingMachineApp.swift
//  VendingMachine
//
//  Created by Makarov Vyacheslav on 13.11.2026.
//

import SwiftUI

@main
struct VendingMachineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ModuleConfigurator.configureViewModel(with: 150))
        }
    }
}

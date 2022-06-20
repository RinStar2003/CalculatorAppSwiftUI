//
//  CalculatorAppApp.swift
//  CalculatorApp
//
//  Created by мас on 21.01.2022.
//

import SwiftUI

@main
struct CalculatorAppApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorHome()
                .environmentObject(Calculator())
        }
    }
}

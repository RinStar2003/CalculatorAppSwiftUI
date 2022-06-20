//
//  ContentView.swift
//  CalculatorApp
//
//  Created by мас on 26.01.2022.
//

import SwiftUI

struct CalculatorRow: View {
    @EnvironmentObject var calculator: Calculator
    var labels = ["", "", "", ""]
    var colors: [Color] = [.gray, .gray, .gray, .orange]
    let columnCount: Int = 4
    
    var body: some View {
        // Display a button for each column, selecting from the labels and colors given
        HStack(spacing: 10) {
            
            ForEach(0..<columnCount) { i in
                CalculatorButton(label: labels[i], color: colors[i])
                
            }
        }
    }
}

struct CalculatorRow_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorRow(labels: ["1", "2", "3", "+"])
            .previewLayout(.fixed(width: 300, height: 100))
    }
}

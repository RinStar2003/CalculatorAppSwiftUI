//
//  ContentView.swift
//  CalculatorApp
//
//  Created by мас on 21.01.2022.
//

import SwiftUI

struct CalculatorButton: View {
    @EnvironmentObject var calculator: Calculator
    var label: String
    var color: Color
    
    var body: some View {
        Button(action: {
            // Let the model know what button was pressed
            calculator.buttonPressed(label: label)
        }) {
            // Overlay the text onto a circle of the specified color
            ZStack {
                Circle()
                    .fill(color)
                
                Text(label)
                    .font(.title)
            }
        }
        // We want white colour text for the buttons
        .accentColor(.white)
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(label: "1", color: .gray)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}

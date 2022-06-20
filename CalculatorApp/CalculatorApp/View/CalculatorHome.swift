//
//  ContentView.swift
//  CalculatorApp
//
//  Created by мас on 21.01.2022.
//

import SwiftUI
let darkerGray = Color(CGColor(gray: 0.1, alpha: 1))
let darkGray = Color(CGColor(gray: 0.3, alpha: 1))
let columnCount = 4
struct CalculatorHome: View {
    
    @EnvironmentObject var calculator: Calculator
    
    var body: some View {
        
        GeometryReader { geometry in
            
        VStack(alignment: .trailing, spacing: 20) {
            
        
            Spacer()
            
            // Display the curren value
            Text(calculator.displayValue)
                .foregroundColor(.white)
                .font(.system(size: 40))
                .lineLimit(1)
                .padding(.horizontal, 30.0)
            
            // Display the row buttons, each with specified labels
            VStack(spacing: 10) {
                
                CalculatorRow(labels: ["CE", "", "", String("\u{00f7}")], colors: [darkGray, darkGray, darkGray, .orange])
                
                CalculatorRow(labels: ["7","8","9",String("\u{00d7}")])
                
                CalculatorRow(labels: ["4","5","6","-"])
                
                CalculatorRow(labels: ["1","2","3","+"])
                
                CalculatorRow(labels: ["0",".","","="])
                
            }
            .frame(height: geometry.size.height * 0.7)
        }
            
        }
        .padding()
        .background(darkerGray)
    }
}

struct CalculatorHome_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorHome()
            .environmentObject(Calculator())
    }
}

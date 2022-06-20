//
//  Calculator.swift
//  CalculatorApp
//
//  Created by мас on 26.01.2022.
//

import Foundation

class Calculator: ObservableObject {
 
    // Used to update UI
    @Published var displayValue = "0"
    var currentOp: Operator?
    var currentNumber: Double? = 0
    var previousNumber: Double?
    var equaled = false
    var decimalPlace = 0
    
    // Selects the appropriate function based on the label of the button pressed
    func buttonPressed(label: String) {
    
        if label == "CE" {
            
            displayValue = "0"
            reset()
            
        } else if label == "=" {
            
            equalsClicked()
            
        } else if label == "." {
            
            decimalClicked()
            
        } else if let value = Double(label) {
            numberPressed(value: value)
            
        } else {
            operatorPressed(op: Operator(label))
        }
    }
    
    func setDisplayValue(number: Double) {
        
        // Don't display a decimal if the number is an integer
        if number == floor(number) {
            
            displayValue = "\(Int(number))"
            // Otherwise, display the decimal
        } else {
            let decimalPlaces = 10
            displayValue = "\(round(number * pow(10, decimalPlaces)) / pow(10, decimalPlaces))"
        }

    }
    
    // Resets the state of the calculator
    
    func reset() {
        
        currentOp = nil
        currentNumber = 0
        previousNumber = nil
        equaled = false
        decimalPlace = 0
        
    }
    
    // Reterns true if division by 0 could happen
    func checkForDivison() -> Bool {
        if currentOp!.isDivision && (currentNumber == nil && previousNumber == 0 || currentNumber == 0) {
            displayValue = "Err"
            reset()
        }
        return true
    }
    
    func equalsClicked() {
        
        if currentOp != nil {
            
            // Reset the decimal place  for the current number
            decimalPlace = 0
            
            // Guard for divison by 0
         
            if currentOp!.isDivision && (currentNumber == nil && previousNumber == 0 || currentNumber == 0) {
                displayValue = "Err"
                reset()
                return // ТУТ БЫЛА ОШИБКА
            }

            
            // Check if we have  at least one operand
            if currentNumber != nil || previousNumber != nil {
                
                // Compute the total
                
                let total = currentOp!.op(previousNumber ?? currentNumber!, currentNumber ?? previousNumber!)
                
                // Update the First  operand
                
                if currentNumber == nil {
                    currentNumber = previousNumber
                }
                
                // Update the second o
                
                previousNumber = total
                
                equaled = true
                
                // Update the UI
                
                setDisplayValue(number: total)
                
            }
        }
        
    }
    
    func decimalClicked() {
        
        if equaled {
                currentNumber = nil
                previousNumber = nil
                equaled = false
        
        }
        
        if currentNumber == nil {
            currentNumber = 0
        }
        
        decimalPlace = 1
        
        setDisplayValue(number: currentNumber!)
        
        displayValue.append(".")
        
    }
    
    func numberPressed(value: Double) {
        
        if equaled {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        
        if currentNumber == nil {
            currentNumber = value / pow(10, decimalPlace)
        } else {
            
            // If no decimal was typed, add the value as the last digit of the number
            if decimalPlace == 0 {
             currentNumber = currentNumber! * 10 + value
                
                // Otherwise, add the value as the last decimal of the number
                
                
                
            } else {
                
                currentNumber = currentNumber! + value / pow(10, decimalPlace)
                decimalPlace += 1
                
            }
        }
        
        // Update the UI
            setDisplayValue(number: currentNumber!)
    }
    
    func operatorPressed(op: Operator) {
        
        // Reset the decimal
        decimalPlace = 0
        
        // If equals was pressed, reset the current number
        
        if equaled {
            currentNumber = nil
            equaled = false
        }
        
        // If we have two operands, compute them
        
        if currentNumber != nil && previousNumber != nil {
            if checkForDivison() { return }
            let total = currentOp!.op(previousNumber!, currentNumber!)
            previousNumber = total
            currentNumber = nil
            
            // Update the UI
            
            setDisplayValue(number: total)
            
            
            // If only one number has been given, move it to the second operand
        } else if previousNumber == nil {
            previousNumber = currentNumber
            currentNumber = nil
        }
        currentOp = op
    }
}



func pow(_ base: Int, _ exp: Int) -> Double {
    
    return pow(Double(base), Double(exp))
    
}

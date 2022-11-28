//
//  CalculatorButtonsView.swift
//  CalculatorSwiftUI
//
//  Created by Mert Duran on 27.11.2022.
//

import SwiftUI

struct CalcButtonModel: Identifiable {
    let id = UUID()
    let calcButton: CalcButton
    var color: Color = foregroundDigitsColor
}

struct RowOfCalculatorButtonsModel: Identifiable {
    let id = UUID()
    let row: [CalcButtonModel]
}

struct CalculatorButtonsView: View {
    @Binding var currentComputation: String
    @Binding var mainResult: String
    
    let buttonData: [RowOfCalculatorButtonsModel] = [
        RowOfCalculatorButtonsModel(row: [
            CalcButtonModel(calcButton: .clear, color: foregroundTopButtonColor),
            CalcButtonModel(calcButton: .negative, color: foregroundTopButtonColor),
            CalcButtonModel(calcButton: .percent, color: foregroundTopButtonColor),
            CalcButtonModel(calcButton: .divide, color: foregroundRightButtonColor)
        ]),
        RowOfCalculatorButtonsModel(row: [
            CalcButtonModel(calcButton: .seven),
            CalcButtonModel(calcButton: .eight),
            CalcButtonModel(calcButton: .nine),
            CalcButtonModel(calcButton: .multiply, color: foregroundRightButtonColor)
        ]),
        
        RowOfCalculatorButtonsModel(row: [
            CalcButtonModel(calcButton: .four),
            CalcButtonModel(calcButton: .five),
            CalcButtonModel(calcButton: .six),
            CalcButtonModel(calcButton: .divide, color: foregroundRightButtonColor)
        ]),
        
        RowOfCalculatorButtonsModel(row: [
            CalcButtonModel(calcButton: .one),
            CalcButtonModel(calcButton: .two),
            CalcButtonModel(calcButton: .three),
            CalcButtonModel(calcButton: .add, color: foregroundRightButtonColor)
        ]),
        
        RowOfCalculatorButtonsModel(row: [
            CalcButtonModel(calcButton: .undo),
            CalcButtonModel(calcButton: .zero),
            CalcButtonModel(calcButton: .decimal),
            CalcButtonModel(calcButton: .equal, color: foregroundRightButtonColor)
        ])
        
    ]
    
    var body: some View {
        Grid() {
            ForEach(buttonData) { rowOfCalculationsButtonsModel in
                GridRow {
                    ForEach(rowOfCalculationsButtonsModel.row) { calcButtonModel in
                        Button(action: {
                            //logic
                            buttonPressed(calcButton: calcButtonModel.calcButton)
                        }, label: {
                            ButtonView(calcButton: calcButtonModel.calcButton,
                                       fgColor: calcButtonModel.color,
                                       bgColor: buttonBGColor)
                        })
                        
                    }
                }
            }
        }
        .padding()
        .background(secondaryBGColor.cornerRadius(25))
    }
    
    func buttonPressed(calcButton: CalcButton) {
        //func logic
        switch calcButton {
        case .clear:
            currentComputation = ""
            mainResult = "0"
            
        case .equal, .negative:
            if !currentComputation.isEmpty {
                if !lastCharacterIsAnOperator(str: currentComputation) {
                    let sign = calcButton == .negative ? -1.0 : 1.0
                    mainResult = formatResult(val: sign * calculateResults())
                    
                    if calcButton == .negative {
                        currentComputation = mainResult
                    }
//                    var sign: Int
//                    comment outlar yukarıdaki ternary nın uzun hali
//                    if (calcButton == .negative) {
//                        sign = -1.0
//                    }else {
//                        sign = 1.0
//                    }
//
                }
            }
        case .decimal:
            if let lastOccurenceOfDecimal = currentComputation.lastIndex(of: ".") {
                if lastcharIsDigit(str: currentComputation) {
                    let startIndex = currentComputation.index(lastOccurenceOfDecimal, offsetBy: 1)
                    let endIndex = currentComputation.endIndex
                    let range = startIndex..<endIndex
                    
                    let rightSubstring = String(currentComputation[range])
                    
                    //only have digits to the right "."
                    //that means do not add another "."
                    //otherwise we can add another point
                    if Int(rightSubstring) == nil && !rightSubstring.isEmpty {
                        currentComputation += "."
                    }
                }
            }else {
                if currentComputation.isEmpty {
                    currentComputation += "0."
                }else if lastcharIsDigit(str: currentComputation) {
                    currentComputation += "."
                }
            }
        case .percent:
            if lastcharIsDigit(str: currentComputation) {
                appendToCurrentComputation(calcButton: calcButton)
            }
        case .add, .subtract, .multiply, .divide:
            if lastcharIsDigit(str: currentComputation) {
                appendToCurrentComputation(calcButton: calcButton)
            }
            
        case .undo:
            currentComputation = String(currentComputation.dropLast())
            
        default:
            //1 0
            appendToCurrentComputation(calcButton: calcButton)
        }
    }
    
//    Implements the actual computation
    func calculateResults() -> Double {
        let visibleWorkings: String = currentComputation
        var workings = visibleWorkings.replacingOccurrences(of: "%", with: "*0.01")
        workings = workings.replacingOccurrences(of: multiplySymbol, with: "*")
        
        workings = workings.replacingOccurrences(of: divisionSymbol, with: "/")
//        if we have "35." will be replaced by 35.0
        if getLastChar(str: visibleWorkings) == "." {
            workings += "0"
        }
        
//        keypoint !
//        Actual computation
        
        let expr = NSExpression(format: workings)
        let exprValue = expr.expressionValue(with: nil, context: nil) as! Double
        
        return exprValue
    }
    
    func appendToCurrentComputation(calcButton: CalcButton) {
        currentComputation += calcButton.rawValue
    }
}

struct CalculatorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonsView(currentComputation: .constant("5 + 17"), mainResult: .constant("22"))
    }
}

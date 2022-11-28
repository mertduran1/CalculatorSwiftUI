//
//  ButtonView.swift
//  CalculatorSwiftUI
//
//  Created by Mert Duran on 27.11.2022.
//

import SwiftUI

struct ButtonView: View {
    let calcButton: CalcButton
    let fgColor: Color
    let bgColor: Color
    
    var systemImage: String? {
        let value = calcButton.rawValue
        return value.contains("IMAGE") ? value.replacingOccurrences(of: "IMAGE", with: "") : nil
    }
    var text: String? {
        let value = calcButton.rawValue
        return value.contains("IMAGE") ? nil : value
    }
    let buttonDim: CGFloat = UIDevice.isiPad ? UIScreen.main.bounds.width / 6 : UIScreen.main.bounds.width / 5
    
    var body: some View {
        ZStack {
            Text(text ?? "")
            Image(systemName: systemImage ?? "")
        }
        .font(UIDevice.isiPad ? .largeTitle : .title2)
        .fontWeight(UIDevice.isiPad ? .bold : .semibold)
        .frame(width: buttonDim, height: buttonDim)
        .foregroundColor(fgColor)
        .background(bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: bgColor.opacity(0.5), radius: 5, x: 5, y: 5)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonView(calcButton: .negative, fgColor: foregroundDigitsColor, bgColor: secondaryBGColor)
            
            ButtonView(calcButton: .undo, fgColor: foregroundDigitsColor, bgColor: secondaryBGColor)
            
            ButtonView(calcButton: .divide, fgColor: foregroundDigitsColor, bgColor: secondaryBGColor)
            
            
            ButtonView(calcButton: .five, fgColor: foregroundRightButtonColor, bgColor: secondaryBGColor)
            
            ButtonView(calcButton: .multiply, fgColor: foregroundDigitsColor, bgColor: secondaryBGColor)
        }
    }
}

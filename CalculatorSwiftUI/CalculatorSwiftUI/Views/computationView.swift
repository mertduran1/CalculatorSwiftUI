//
//  computationView.swift
//  CalculatorSwiftUI
//
//  Created by Mert Duran on 27.11.2022.
//

import SwiftUI

struct computationView: View {
    let currentComputation: String
    let mainResult: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Text(currentComputation)
                    .foregroundColor(foregroundDigitsColor)
                    .font(UIDevice.isiPad ? .largeTitle : .body)
                .lineLimit(1)
            }
            .minimumScaleFactor(0.1)
            
            HStack {
                Spacer()
                Text(mainResult)
                    .foregroundColor(foregroundDigitsColor)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                .lineLimit(1)
            }
            .minimumScaleFactor(0.1)

        }.padding(.horizontal)
    }
}

struct computationView_Previews: PreviewProvider {
    static var previews: some View {
        computationView(currentComputation: "11 + 11", mainResult: "22")
    }
}

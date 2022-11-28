//
//  sunMoonView.swift
//  CalculatorSwiftUI
//
//  Created by Mert Duran on 27.11.2022.
//

import SwiftUI

struct sunMoonView: View {
    var lightMode: Bool
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "sun.min")
                .imageScale(.large)
                .foregroundColor(lightMode ? sunOrMoonSelectedColor : sunOrMoonNotSelectedColor)
                
            
            
            Image(systemName: "moon")
                .imageScale(.large)
                .foregroundColor(lightMode ? sunOrMoonNotSelectedColor  : sunOrMoonSelectedColor )
        }
        .font(UIDevice.isiPad ? .largeTitle : .body)
        .fontWeight(UIDevice.isiPad ? .semibold : .regular)
        
        .padding()
            .background(secondaryBGColor)
            .cornerRadius(20)
    }
}

struct sunMoonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            sunMoonView(lightMode: true)
            sunMoonView(lightMode: false)
        }
    }
}

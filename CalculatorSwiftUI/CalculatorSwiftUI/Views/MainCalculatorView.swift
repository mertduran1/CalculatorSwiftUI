//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Mert Duran on 27.11.2022.
//

import SwiftUI

struct MainCalculatorView: View {
    @State var lightMode: Bool = true
    @State var currentComputation: String = ""
    @State var mainResult: String = "0"
    
    var body: some View {
        ZStack {
            primaryBGColor.ignoresSafeArea()
            
            VStack {
                sunMoonView(lightMode: lightMode)
                    .onTapGesture {
                        withAnimation {
                            lightMode.toggle()
                        }
                    }
                    
                Spacer()
                
                computationView(currentComputation: currentComputation, mainResult: mainResult)
                    .padding(.horizontal,UIDevice.isiPad ? UIScreen.main.bounds.width * 0.15 : 0)
                
                Spacer()
                
                CalculatorButtonsView(currentComputation: $currentComputation, mainResult: $mainResult)
                
                if UIDevice.isiPad {
                    Spacer()
                }
            }
            .padding()
        }
        .environment(\.colorScheme,
                      lightMode ? .light : .dark
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainCalculatorView()
    }
}

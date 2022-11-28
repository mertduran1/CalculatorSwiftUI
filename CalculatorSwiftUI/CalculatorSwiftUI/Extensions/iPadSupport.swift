//
//  iPadSupport.swift
//  CalculatorSwiftUI
//
//  Created by Mert Duran on 28.11.2022.
//

import SwiftUI

extension UIDevice {
    static var isiPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isiPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

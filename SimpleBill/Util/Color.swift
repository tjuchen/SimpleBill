//
//  Color.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/17.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    static func colorWithHexString(hexString : String) -> UIColor {
        var alpha: CGFloat = 0.0
        var red: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var green: CGFloat = 0.0
        
        let colorString = hexString.replacingOccurrences(of: "#", with: "").uppercased()
        switch colorString.count {
        case 3:
            alpha = 1.0
            red   = colorComponentFrom(str: colorString, start: 0, length: 1)
            green = colorComponentFrom(str: colorString, start: 1, length: 1)
            blue  = colorComponentFrom(str: colorString, start: 2, length: 1)
            break
        case 4:
            alpha = colorComponentFrom(str: colorString, start: 0, length: 1)
            red   = colorComponentFrom(str: colorString, start: 1, length: 1)
            green = colorComponentFrom(str: colorString, start: 2, length: 1)
            blue  = colorComponentFrom(str: colorString, start: 3, length: 1)
            break
        case 6:
            alpha = 1.0
            red   = colorComponentFrom(str: colorString, start: 0, length: 2)
            green = colorComponentFrom(str: colorString, start: 2, length: 2)
            blue  = colorComponentFrom(str: colorString, start: 4, length: 2)
            break
        case 8:
            alpha = colorComponentFrom(str: colorString, start: 0, length: 2)
            red   = colorComponentFrom(str: colorString, start: 2, length: 2)
            green = colorComponentFrom(str: colorString, start: 4, length: 2)
            blue  = colorComponentFrom(str: colorString, start: 6, length: 2)
            break
        default:
            break
        }
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private static func colorComponentFrom(str: String, start: Int, length: Int) -> CGFloat {
        let startIndex = str.index(str.startIndex, offsetBy: start)
        let endIndex = str.index(startIndex, offsetBy: length-1)
        
        let substring = String(str[startIndex...endIndex])
        
        let fullHex = length == 2 ? substring : substring.appending(substring)

        var hexComponent: UInt64 = 0
        let scanner = Scanner(string: fullHex)
        scanner.scanHexInt64(&hexComponent)
        
        return CGFloat(hexComponent) / 255.0;
    }
}

extension Color {
    static func colorWithHexString(hexString : String) -> Color {
        return colorWithHexString(hexString: hexString, alpha: nil)
    }
    
    static func colorWithHexString(hexString : String, alpha: Double?) -> Color {
        var opacity: Double = 0.0
        var red: Double = 0.0
        var blue: Double = 0.0
        var green: Double = 0.0
        
        let colorString = hexString.replacingOccurrences(of: "#", with: "").uppercased()
        switch colorString.count {
        case 3:
            opacity = alpha ?? 1.0
            red   = colorComponentFrom(str: colorString, start: 0, length: 1)
            green = colorComponentFrom(str: colorString, start: 1, length: 1)
            blue  = colorComponentFrom(str: colorString, start: 2, length: 1)
            break
        case 4:
            opacity = alpha ?? colorComponentFrom(str: colorString, start: 0, length: 1)
            red   = colorComponentFrom(str: colorString, start: 1, length: 1)
            green = colorComponentFrom(str: colorString, start: 2, length: 1)
            blue  = colorComponentFrom(str: colorString, start: 3, length: 1)
            break
        case 6:
            opacity = alpha ?? 1.0
            red   = colorComponentFrom(str: colorString, start: 0, length: 2)
            green = colorComponentFrom(str: colorString, start: 2, length: 2)
            blue  = colorComponentFrom(str: colorString, start: 4, length: 2)
            break
        case 8:
            opacity = alpha ?? colorComponentFrom(str: colorString, start: 0, length: 2)
            red   = colorComponentFrom(str: colorString, start: 2, length: 2)
            green = colorComponentFrom(str: colorString, start: 4, length: 2)
            blue  = colorComponentFrom(str: colorString, start: 6, length: 2)
            break
        default:
            break
        }
        
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    private static func colorComponentFrom(str: String, start: Int, length: Int) -> Double {
        let startIndex = str.index(str.startIndex, offsetBy: start)
        let endIndex = str.index(startIndex, offsetBy: length-1)
        
        let substring = String(str[startIndex...endIndex])
        
        let fullHex = length == 2 ? substring : substring.appending(substring)

        var hexComponent: UInt64 = 0
        let scanner = Scanner(string: fullHex)
        scanner.scanHexInt64(&hexComponent)
        
        return Double(hexComponent) / 255.0;
    }
}

//
//  UIColor + Extension.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIColor {
    static let activeBlueColor = UIColor(hexString: "#2882F1")
    static let inactiveGrayColor = UIColor(hexString: "#C3C3C3")
    
    static let lightGray = UIColor(hexString: "#F6F8FE")
    
    // TextColor
    static let lightGrayTextColor = UIColor(hexString: "#9CA4AB")
    static let darkGrayTextColor = UIColor(hexString: "#78828A")
    static let boldGrayTextColor = UIColor(hexString: "#6C6C6C")
    static let purpleTextColor = UIColor(hexString: "#514EB6")
    static let greenTextColor = UIColor(hexString: "#B5CB5C")
    static let blackTextColor = UIColor(hexString: "#111111")
    static let lightGrayWallpaper = UIColor(hexString: "#F8F8F5")
    static let customGray = UIColor(hexString: "#EDF0FC")
    
    static let customBlue = UIColor(hexString: "#E6F6FF")
    static let customLightBlue = UIColor(hexString: "#E8F6FD")
    static let customPink = UIColor(hexString: "#FFE5EC")
    
    //TextColor TabBar
    static var tabBarItemAccent = UIColor.white
    static var mainWhite = UIColor.white
    static var tabBarItemLight = UIColor.activeBlueColor
}

//
//  Font+Extensions.swift
//  Beat100
//
//  Created by 나현흠 on 7/21/25.
//

import Foundation
import SwiftUI

extension Font {
    enum AppleSDGothicNeo: String {
        case black = "AppleSDGothicNeo-Black"
        case bold = "AppleSDGothicNeo-Bold"
        case extrabold = "AppleSDGothicNeo-ExtraBold"
        case extraLight = "AppleSDGothicNeo-ExtraLight"
        case light = "AppleSDGothicNeo-Light"
        case medium = "AppleSDGothicNeo-Medium"
        case regular = "AppleSDGothicNeo-Regular"
        case semiBold = "AppleSDGothicNeo-SemiBold"
        case thin = "AppleSDGothicNeo-Thin"
    }
    
    static func appleSDGothicNeo(_ type: AppleSDGothicNeo, size: CGFloat) -> Font {
        return .custom(type.rawValue, size: size)
    }
}

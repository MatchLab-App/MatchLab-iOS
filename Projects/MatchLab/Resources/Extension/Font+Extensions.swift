//
//  Font+Extensions.swift
//  Beat100
//
//  Created by 나현흠 on 7/21/25.
//

import Foundation
import SwiftUI

extension Font {
    enum AppleSDGothicNeo {
        case black
        case bold
        case extrabold
        case extraLight
        case light
        case medium
        case regular
        case semiBold
        case thin
        
        var value: String {
            switch self {
            case .black:
                return "AppleSDGothicNeo-Black.ttf"
            case .bold:
                return "AppleSDGothicNeo-Bold.ttf"
            case .extrabold:
                return "AppleSDGothicNeo-ExtraBold.ttf"
            case .extraLight:
                return "AppleSDGothicNeo-ExtraLight.ttf"
            case .light:
                return "AppleSDGothicNeo-Light.ttf"
            case .medium:
                return "AppleSDGothicNeo-Medium.ttf"
            case .regular:
                return "AppleSDGothicNeo-Regular.ttf"
            case .semiBold:
                return "AppleSDGothicNeo-SemiBold.ttf"
            case .thin:
                return "AppleSDGothicNeo-Thin.ttf"
            }
        }
    }
    
    static func nanumSquareNeo(type: NanumSquareNeo, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}

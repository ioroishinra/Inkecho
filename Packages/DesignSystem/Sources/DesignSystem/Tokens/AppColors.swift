import SwiftUI

public extension Color {
    static let appBg       = Color("AppBg",       bundle: .module)
    static let appAccent   = Color("AppAccent",   bundle: .module)
    static let appFaint    = Color("AppFaint",    bundle: .module)
    static let appGhost    = Color("AppGhost",    bundle: .module)
    static let appBorder   = Color("AppBorder",   bundle: .module)
}

// Fallback raw values for previews without asset catalog
public extension ShapeStyle where Self == Color {
    static var bg: Color     { Color(red: 0.059, green: 0.051, blue: 0.043) }
    static var accent: Color { Color(red: 0.780, green: 0.620, blue: 0.380) }
}

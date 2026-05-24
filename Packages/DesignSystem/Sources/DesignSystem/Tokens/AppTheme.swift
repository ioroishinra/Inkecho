import SwiftUI

public enum AppTheme: String, CaseIterable, Identifiable {
    case darkInk   = "dark"
    case warmPaper = "warm"
    case sakura    = "sakura"

    public var id: String { rawValue }

    public var label: String {
        switch self {
        case .darkInk:   return "暗墨"
        case .warmPaper: return "和紙"
        case .sakura:    return "夜桜"
        }
    }

    public var colorScheme: ColorScheme {
        switch self {
        case .warmPaper: return .light
        default:         return .dark
        }
    }

    // MARK: – Backgrounds
    public var bg: Color {
        switch self {
        case .darkInk:   return Color(red:0.059, green:0.051, blue:0.043)
        case .warmPaper: return Color(red:0.941, green:0.902, blue:0.824)
        case .sakura:    return Color(red:0.063, green:0.047, blue:0.094)
        }
    }
    public var surface: Color {
        switch self {
        case .darkInk:   return Color(red:0.102, green:0.086, blue:0.071)
        case .warmPaper: return Color(red:0.980, green:0.957, blue:0.894)
        case .sakura:    return Color(red:0.102, green:0.063, blue:0.157)
        }
    }
    public var faint: Color {
        switch self {
        case .darkInk:   return Color(red:0.133, green:0.114, blue:0.086)
        case .warmPaper: return Color(red:0.902, green:0.855, blue:0.769)
        case .sakura:    return Color(red:0.133, green:0.078, blue:0.220)
        }
    }
    public var border: Color {
        switch self {
        case .darkInk:   return Color(red:0.180, green:0.157, blue:0.125)
        case .warmPaper: return Color(red:0.784, green:0.722, blue:0.596)
        case .sakura:    return Color(red:0.188, green:0.094, blue:0.282)
        }
    }

    // MARK: – Text
    public var text: Color {
        switch self {
        case .darkInk:   return Color(red:0.941, green:0.910, blue:0.847)
        case .warmPaper: return Color(red:0.173, green:0.118, blue:0.063)
        case .sakura:    return Color(red:0.949, green:0.878, blue:0.973)
        }
    }
    public var textDim: Color {
        switch self {
        case .darkInk:   return Color(red:0.753, green:0.659, blue:0.533)
        case .warmPaper: return Color(red:0.424, green:0.306, blue:0.188)
        case .sakura:    return Color(red:0.753, green:0.565, blue:0.816)
        }
    }
    public var textFaint: Color {
        switch self {
        case .darkInk:   return Color(red:0.478, green:0.408, blue:0.345)
        case .warmPaper: return Color(red:0.612, green:0.471, blue:0.314)
        case .sakura:    return Color(red:0.502, green:0.376, blue:0.565)
        }
    }
    public var textGhost: Color {
        switch self {
        case .darkInk:   return Color(red:0.290, green:0.243, blue:0.188)
        case .warmPaper: return Color(red:0.784, green:0.659, blue:0.471)
        case .sakura:    return Color(red:0.251, green:0.157, blue:0.345)
        }
    }

    // MARK: – Accent
    public var accent: Color {
        switch self {
        case .darkInk:   return Color(red:0.831, green:0.596, blue:0.431)
        case .warmPaper: return Color(red:0.620, green:0.376, blue:0.157)
        case .sakura:    return Color(red:0.847, green:0.533, blue:0.722)
        }
    }
    public var accentDark: Color {
        switch self {
        case .darkInk:   return Color(red:0.478, green:0.314, blue:0.188)
        case .warmPaper: return Color(red:0.424, green:0.243, blue:0.078)
        case .sakura:    return Color(red:0.565, green:0.220, blue:0.408)
        }
    }
}

// MARK: – Environment key
private struct AppThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = .darkInk
}
public extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

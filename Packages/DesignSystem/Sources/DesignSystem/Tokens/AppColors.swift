import SwiftUI

// Static colour constants matching the default darkInk theme.
// Views that need dynamic theming read from @Environment(\.appTheme).
public extension Color {
    static let appBg          = AppTheme.darkInk.bg
    static let appSurface     = AppTheme.darkInk.surface
    static let appFaint       = AppTheme.darkInk.faint
    static let appBorder      = AppTheme.darkInk.border
    static let appText        = AppTheme.darkInk.text
    static let appTextDim     = AppTheme.darkInk.textDim
    static let appTextFaint   = AppTheme.darkInk.textFaint
    static let appTextGhost   = AppTheme.darkInk.textGhost
    static let appAccent      = AppTheme.darkInk.accent
    static let appAccentDark  = AppTheme.darkInk.accentDark
}

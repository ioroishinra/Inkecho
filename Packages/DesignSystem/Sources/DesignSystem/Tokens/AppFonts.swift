import SwiftUI

public enum AppFonts {
    /// Kyoukasho-style font. YuKyokasho on macOS, Klee One on iOS.
    public static func kyoukasho(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        #if os(macOS)
        return Font.custom("YuKyokasho", size: size).weight(weight)
        #else
        return Font.custom("KleeOne-Regular", size: size).weight(weight)
        #endif
    }

    public static func mincho(size: CGFloat) -> Font { kyoukasho(size: size) }
}

public extension View {
    func kyoukashoFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.font(AppFonts.kyoukasho(size: size, weight: weight))
    }
}

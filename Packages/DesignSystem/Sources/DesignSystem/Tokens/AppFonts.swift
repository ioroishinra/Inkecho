import SwiftUI

public enum AppFonts {
    /// Kyoukasho-style font. Klee One on macOS and iOS.
    public static func kyoukasho(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        Font.custom("KleeOne-Regular", size: size).weight(weight)
    }

    public static func mincho(size: CGFloat) -> Font { kyoukasho(size: size) }
}

public extension View {
    func kyoukashoFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.font(AppFonts.kyoukasho(size: size, weight: weight))
    }
}

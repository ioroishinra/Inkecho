import SwiftUI

public enum AppFonts {
    /// Kyoukasho-style font. YuKyokasho on macOS, Klee One on iOS.
    public static func kyoukasho(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        #if os(macOS)
        Font.custom("YuKyokasho", size: size).weight(weight)
        #else
        Font.custom("KleeOne-Regular", size: size).weight(weight)
        #endif
    }

    /// Kaiti-style font for Chinese text. STKaiti on both platforms.
    public static func kaiti(size: CGFloat) -> Font {
        Font.custom("STKaiti", size: size)
    }

    public static func mincho(size: CGFloat) -> Font { kyoukasho(size: size) }
}

public extension View {
    func kyoukashoFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.font(AppFonts.kyoukasho(size: size, weight: weight))
    }

    func kaitiFont(size: CGFloat) -> some View {
        self.font(AppFonts.kaiti(size: size))
    }
}

import SwiftUI

public struct ToastView: View {
    @Environment(\.appTheme) private var theme
    public let message: String

    public init(_ message: String) { self.message = message }

    public var body: some View {
        Text(message)
            .kyoukashoFont(size: 11)
            .tracking(1.5)
            .foregroundStyle(theme.textFaint)
            .padding(.horizontal, AppSpacing.md)
            .padding(.vertical, AppSpacing.sm)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .shadow(color: .black.opacity(0.3), radius: 8)
    }
}

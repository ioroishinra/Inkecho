import SwiftUI

public struct EmptyStateView: View {
    @Environment(\.appTheme) private var theme
    public let message: String
    public let buttonLabel: String
    public let action: () -> Void

    public init(message: String, buttonLabel: String, action: @escaping () -> Void) {
        self.message = message; self.buttonLabel = buttonLabel; self.action = action
    }

    public var body: some View {
        VStack(spacing: AppSpacing.lg) {
            Text(message)
                .kyoukashoFont(size: 14)
                .tracking(3)
                .foregroundStyle(theme.textDim)
            Button(buttonLabel, action: action)
                .kyoukashoFont(size: 11)
                .tracking(2)
                .foregroundStyle(theme.textFaint)
                .padding(.horizontal, AppSpacing.xl)
                .padding(.vertical, 10)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(theme.border, lineWidth: 1))
                .buttonStyle(.plain)
        }
    }
}

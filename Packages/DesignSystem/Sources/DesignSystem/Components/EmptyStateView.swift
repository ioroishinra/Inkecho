import SwiftUI

public struct EmptyStateView: View {
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
                .foregroundStyle(Color(white: 0.45))
            Button(buttonLabel, action: action)
                .kyoukashoFont(size: 11)
                .tracking(2)
                .foregroundStyle(Color(white: 0.40))
                .padding(.horizontal, AppSpacing.xl)
                .padding(.vertical, 10)
                .overlay(RoundedRectangle(cornerRadius: 3)
                    .stroke(Color(white: 0.22), lineWidth: 1))
        }
    }
}

import SwiftUI

public struct ActionButton: View {
    public enum Style { case ghost, accent }
    @Environment(\.appTheme) private var theme

    public let label: String
    public let style: Style
    public let action: () -> Void

    public init(_ label: String, style: Style = .ghost, action: @escaping () -> Void) {
        self.label = label; self.style = style; self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(label)
                .kyoukashoFont(size: 12)
                .tracking(2)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .foregroundStyle(style == .accent ? theme.accent : theme.textFaint)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(style == .accent ? theme.accentDark : theme.border, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

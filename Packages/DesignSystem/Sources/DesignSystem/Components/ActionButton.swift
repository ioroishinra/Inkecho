import SwiftUI

public struct ActionButton: View {
    public enum Style { case ghost, accent }
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
        }
        .buttonStyle(AppButtonStyle(style: style))
    }
}

private struct AppButtonStyle: ButtonStyle {
    let style: ActionButton.Style
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(style == .accent
                ? Color(red: 0.78, green: 0.62, blue: 0.38)
                : Color(white: 0.55))
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(style == .accent
                        ? Color(red: 0.50, green: 0.38, blue: 0.20)
                        : Color(white: 0.22), lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

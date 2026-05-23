import SwiftUI

public struct FlashCardView<Front: View, Back: View>: View {
    public let isFlipped: Bool
    public let front: Front
    public let back: Back
    public let onTap: () -> Void

    public init(isFlipped: Bool, onTap: @escaping () -> Void,
                @ViewBuilder front: () -> Front,
                @ViewBuilder back: () -> Back) {
        self.isFlipped = isFlipped
        self.onTap = onTap
        self.front = front()
        self.back = back()
    }

    public var body: some View {
        ZStack {
            front
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(.degrees(isFlipped ? 90 : 0), axis: (x: 0, y: 1, z: 0))
            back
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(isFlipped ? 0 : -90), axis: (x: 0, y: 1, z: 0))
        }
        .animation(.easeInOut(duration: 0.25), value: isFlipped)
        .onTapGesture(perform: onTap)
        .frame(maxWidth: .infinity)
        .frame(height: 260)
        .background(Color(white: 0.09))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay(RoundedRectangle(cornerRadius: 4)
            .stroke(Color(white: 0.18), lineWidth: 1))
    }
}

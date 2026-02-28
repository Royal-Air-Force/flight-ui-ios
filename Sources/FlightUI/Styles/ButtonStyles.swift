import SwiftUI

// MARK: - Button Style Defaults

private enum ButtonDefaults {
    static let pressedOpacity: CGFloat = 0.6
    static let pressedScale: CGFloat = 0.95
    static let tonalBackgroundOpacity: CGFloat = 0.18
}

// MARK: - Button Variant

public enum ButtonVariant: Sendable {
    case filled
    case tonal
    case outline
    case text
}

// MARK: - Button Shape

public enum ButtonShape: Sendable {
    case capsule
    case circle
}

// MARK: - Core Button Type

public enum CoreButtonType: Sendable {
    case nominal
    case advisory
    case caution
    case warning
}

// MARK: - Flight Button Style

public struct FlightButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    private let variant: ButtonVariant
    private let shape: ButtonShape
    private let coreType: CoreButtonType?

    public init(
        variant: ButtonVariant,
        shape: ButtonShape = .capsule,
        coreType: CoreButtonType? = nil
    ) {
        self.variant = variant
        self.shape = shape
        self.coreType = coreType
    }

    public func makeBody(configuration: Configuration) -> some View {
        Group {
            switch shape {
            case .capsule:
                configuration.label
                    .padding(.horizontal, horizontalPadding)
                    .frame(minWidth: minSize, minHeight: minSize)
                    .foregroundColor(foregroundColor)
                    .background(backgroundColor)
                    .fontStyle(theme.typography.bodyBold)
                    .clipShape(Capsule())
                    .overlay {
                        if variant == .outline {
                            Capsule()
                                .strokeBorder(foregroundColor, lineWidth: theme.size.border)
                        }
                    }
            case .circle:
                configuration.label
                    .frame(minWidth: minSize, minHeight: minSize)
                    .foregroundColor(foregroundColor)
                    .background(backgroundColor)
                    .fontStyle(theme.typography.bodyBold)
                    .clipShape(Circle())
                    .overlay {
                        if variant == .outline {
                            Circle()
                                .strokeBorder(foregroundColor, lineWidth: theme.size.border)
                        }
                    }
            }
        }
        .opacity(configuration.isPressed ? ButtonDefaults.pressedOpacity : 1.0)
        .scaleEffect(configuration.isPressed ? ButtonDefaults.pressedScale : 1.0)
        .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }

    // MARK: - Computed Properties

    private var horizontalPadding: CGFloat {
        switch shape {
        case .capsule:
            return theme.spacing.grid4x
        case .circle:
            return 0
        }
    }

    private var minSize: CGFloat {
        theme.size.medium
    }

    // MARK: - Colors

    private var foregroundColor: Color {
        guard isEnabled else { return theme.color.onDisabled }

        switch variant {
        case .filled:
            return theme.color.onCore
        case .tonal, .outline, .text:
            return coreColor
        }
    }

    private var backgroundColor: Color {
        guard isEnabled else {
            return variant == .text || variant == .outline ? .clear : theme.color.disabled
        }

        switch variant {
        case .filled:
            return coreColor
        case .tonal:
            return coreColor.opacity(ButtonDefaults.tonalBackgroundOpacity)
        case .outline, .text:
            return .clear
        }
    }

    private var coreColor: Color {
        guard let coreType else { return theme.color.nominal }

        switch coreType {
        case .nominal:
            return theme.color.nominal
        case .advisory:
            return theme.color.primary
        case .caution:
            return theme.color.caution
        case .warning:
            return theme.color.warning
        }
    }
}

// MARK: - ButtonStyle Extensions

public extension ButtonStyle where Self == FlightButtonStyle {

    // MARK: Standard Variants (Capsule Shape)

    /// Filled button with solid background
    static var filled: FlightButtonStyle {
        FlightButtonStyle(variant: .filled, shape: .capsule)
    }

    /// Tonal button with translucent background
    static var tonal: FlightButtonStyle {
        FlightButtonStyle(variant: .tonal, shape: .capsule)
    }

    /// Outline button with border only
    static var outline: FlightButtonStyle {
        FlightButtonStyle(variant: .outline, shape: .capsule)
    }

    /// Text-only button with no background
    static var text: FlightButtonStyle {
        FlightButtonStyle(variant: .text, shape: .capsule)
    }

    // MARK: Icon Variants (Circle Shape)

    /// Filled circular icon button
    static var filledIcon: FlightButtonStyle {
        FlightButtonStyle(variant: .filled, shape: .circle)
    }

    /// Tonal circular icon button
    static var tonalIcon: FlightButtonStyle {
        FlightButtonStyle(variant: .tonal, shape: .circle)
    }

    /// Outline circular icon button
    static var outlineIcon: FlightButtonStyle {
        FlightButtonStyle(variant: .outline, shape: .circle)
    }

    /// Text-only circular icon button
    static var textIcon: FlightButtonStyle {
        FlightButtonStyle(variant: .text, shape: .circle)
    }

    // MARK: Core Alert Variants

    /// Advisory button (uses primary color)
    static var advisory: FlightButtonStyle {
        FlightButtonStyle(variant: .filled, shape: .capsule, coreType: .advisory)
    }

    /// Caution button (yellow/amber)
    static var caution: FlightButtonStyle {
        FlightButtonStyle(variant: .filled, shape: .capsule, coreType: .caution)
    }

    /// Warning button (red)
    static var warning: FlightButtonStyle {
        FlightButtonStyle(variant: .filled, shape: .capsule, coreType: .warning)
    }

    // MARK: Custom Configuration

    /// Create a custom button style with specific variant, shape, and core type
    static func custom(
        variant: ButtonVariant,
        shape: ButtonShape = .capsule,
        coreType: CoreButtonType? = nil
    ) -> FlightButtonStyle {
        FlightButtonStyle(variant: variant, shape: shape, coreType: coreType)
    }
}

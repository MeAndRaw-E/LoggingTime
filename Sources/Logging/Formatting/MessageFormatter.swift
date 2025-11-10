import Foundation

struct MessageFormatter {
    let level: LogLevel
    let message: String
    let location: LocationInfo
    let callerLocation: LocationInfo?

    var formatted: [String] {
        var output = [
            "",
            LoggingConstants.boxTop,
            "\(LoggingConstants.boxSide)\(formatLogLevel()) \(LoggingConstants.boxSide)",
        ]

        let locationLines = location.formatted.split(separator: "\n")
        output.append(
            contentsOf: locationLines.map {
                "\(LoggingConstants.boxSide) \($0.padding(toLength: LoggingConstants.contentWidth, withPad: " ", startingAt: 0)) \(LoggingConstants.boxSide)"
            }
        )

        if let callerLocation {
            let callerLines = callerLocation.formatted.split(separator: "\n")
            output.append(
                contentsOf: callerLines.map {
                    "\(LoggingConstants.boxSide) \($0.padding(toLength: LoggingConstants.contentWidth, withPad: " ", startingAt: 0)) \(LoggingConstants.boxSide)"
                }
            )
        }

        output.append(contentsOf: [
            LoggingConstants.boxBottom,
            "\(LoggingConstants.leftDots)\(LoggingConstants.logContentHeader)\(LoggingConstants.rightDots)",
            message,
            LoggingConstants.finalSeparator,
        ])

        return output
    }

    private func formatLogLevel() -> String {
        "[\(level.icon) \(level.description)]".centered(
            in: String(repeating: " ", count: LoggingConstants.contentWidth)
        )
    }
}

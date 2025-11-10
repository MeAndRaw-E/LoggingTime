import Foundation
import SwiftUI

public actor PreviewLogger {
    public static let shared = PreviewLogger()
    public private(set) var logLevel: LogLevel = .info
    private init() {}
    public static func setLogLevel(_ level: LogLevel) {
        Task { await shared.setLogLevelInternal(level) }
    }
    public static func log(
        _ message: String,
        level: LogLevel = .info,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        log(message, level: level, context: .current(file: file, function: function, line: line))
    }
    public static func log(_ message: String, level: LogLevel = .info, context: LoggingContext) {
        #if DEBUG
            guard ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" else { return }
            Task { @Sendable in
                let currentLevel = await shared.logLevel
                guard level >= currentLevel else { return }
                print(
                    MessageFormatter(
                        level: level,
                        message: message,
                        location: LocationInfo(context: context),
                        callerLocation: context.callerContext.map(LocationInfo.init)
                    ).formatted.joined(separator: "\n")
                )
            }
        #endif
    }
    func setLogLevelInternal(_ level: LogLevel) { logLevel = level }
}

import Foundation

public struct LoggingContext: Sendable {
    let file: String
    let function: String
    let line: Int
    let callerContext: CallerContext?

    var fileName: String {
        (file as NSString).lastPathComponent
    }

    public struct CallerContext: Sendable {
        let file: String
        let function: String
        let line: Int

        var fileName: String {
            (file as NSString).lastPathComponent
        }
    }

    public static func current(
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) -> LoggingContext {
        LoggingContext(file: file, function: function, line: line, callerContext: nil)
    }

    public static func withCaller(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        callerFile: String,
        callerFunction: String,
        callerLine: Int
    ) -> LoggingContext {
        let callerContext = CallerContext(
            file: callerFile,
            function: callerFunction,
            line: callerLine
        )
        return LoggingContext(
            file: file,
            function: function,
            line: line,
            callerContext: callerContext
        )
    }
}

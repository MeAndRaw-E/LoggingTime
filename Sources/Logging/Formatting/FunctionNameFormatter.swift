import Foundation

struct FunctionNameFormatter {
    private let function: String

    init(_ function: String) {
        self.function = function
    }

    var formatted: String {
        let cleaned =
            function
            .replacingOccurrences(of: "(_:file:function:line:)", with: "")
            .replacingOccurrences(of: "()", with: "")

        if cleaned == "<top_level>" {
            return cleaned
        }

        if cleaned.contains("(") {
            return cleaned
        }

        return "\(cleaned)()"
    }

    var emoji: String {
        function == "<top_level>" ? LoggingConstants.topLevelFunctionEmoji : LoggingConstants.regularFunctionEmoji
    }
}

import Foundation

import Hollywood

struct NonProgressReportingGenerateNumericString: WorkflowAction {
    let iterations: Int
    let delay: Duration

    func execute() async throws -> String {
        var string = ""
        for index in 0..<iterations {
            string += "\(index),"
            try await Task.sleep(for: delay)
        }

        return string
    }
}

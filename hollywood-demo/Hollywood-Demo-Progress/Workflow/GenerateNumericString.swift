import Foundation

import Hollywood

struct GenerateNumericString: ProgressReportingWorkflowAction {
    typealias T = String

    let iterations: Int
    let delay: Duration
    let pendingUnitCount: Int64

    func execute(withProgress progress: Progress) async throws -> String {
        progress.totalUnitCount = Int64(iterations)
    
        var string = ""
        for index in 0..<iterations {
            string += "\(index),"
            progress.completedUnitCount = Int64(index + 1)
            try await Task.sleep(for: delay)
        }

        return string
    }
}

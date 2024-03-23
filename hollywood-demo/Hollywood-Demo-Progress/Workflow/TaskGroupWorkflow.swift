import Foundation

import Hollywood

/// This workflow action does not conform to the `ProgressReportingWorkflowAction` because it does not explicitly track progress. Instead, all
/// progress tracked in actions submitted to and executed by a `TaskGroup`. Therefore this action acts as a sort of "root" workflow action that delegates its
/// work to child tasks.
struct TaskGroupWorkflow: CompositeWorkflowAction {
    typealias T = String

    func execute() async throws -> String {

        TaskProgress.progress.totalUnitCount = 3

        return try await withThrowingTaskGroup(of: String.self) { group in
            _ = group.addTaskUnlessCancelled {

                // Given the parent's `totalUnitCount` of 3, this task takes up 33% of the total progress.
                let result = try await GenerateNumericString(iterations: 4, delay: .milliseconds(1000), pendingUnitCount: 1).execute()
                return "Group 1 \(result)"
            }

            _ = group.addTaskUnlessCancelled {

                // Given the parent's `totalUnitCount` of 3, this task takes up 33% of the total progress.
                let result = try await GenerateNumericString(iterations: 8, delay: .milliseconds(1000), pendingUnitCount: 1).execute()
                return "Group 2 \(result)"
            }

            _ = group.addTaskUnlessCancelled {

                // Given the parent's `totalUnitCount` of 3, this task takes up 33% of the total progress.
                let result = try await GenerateNumericString(iterations: 16, delay: .milliseconds(50), pendingUnitCount: 1).execute()
                return "Group 3 \(result)"
            }

            var string = ""
            for try await groupString in group {
                string.append(groupString)
                string.append("\n")
            }

            return string
        }
    }
}

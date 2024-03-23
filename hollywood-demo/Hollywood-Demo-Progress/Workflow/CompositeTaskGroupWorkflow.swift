import Foundation

import Hollywood

final class CompositeTaskGroupWorkflow: CompositeWorkflowAction {
}

extension CompositeTaskGroupWorkflow {

    func execute() async throws -> String {

        TaskProgress.progress.totalUnitCount = 100

        let resultA = try await execute(TaskGroupWorkflow(), pendingUnitCount: 20)
        let resultB = try await execute(TaskGroupWorkflow(), pendingUnitCount: 30)
        let resultC = try await execute(TaskGroupWorkflow(), pendingUnitCount: 10)
        let resultD = try await execute(TaskGroupWorkflow(), pendingUnitCount: 40)

        return [
            resultA,
            resultB,
            resultC,
            resultD,
        ].joined(separator: "\n")
    }
}

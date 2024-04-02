import Foundation

import Hollywood

struct StepByStepWorkflow: CompositeWorkflowAction {

    let initialDelay: Duration

    func execute() async throws -> String {
        // At this point the progress doesn't have a `totalUnitCount`, which means a progress view will show
        // an indeterminate state.
        try await Task.sleep(for: initialDelay)

        // Once the `totalUnitCount` is set, the progress is no longer in an indeterminate state, which means a
        // progress view will begin visually tracking progress.
        //
        // For a root level action, it's often convenient to set the total unit count to 100. This makes it super
        // easy to set the child action's progress `pendingUnitCount`, such that all child action's `pendingUnitCount`
        // value add up to 100 (or to put it another add up to 100%).
        try TaskProgress.safeProgress.totalUnitCount = 100

        // This action produces 25% of the workflow's progress.
        let resultA = try await execute(GenerateNumericString(iterations: 10, delay: .milliseconds(200), pendingUnitCount: 25))

        // This action produces 15% of the workflow's progress.
        let resultB = try await execute(GenerateNumericString(iterations: 100, delay: .milliseconds(50), pendingUnitCount: 15))

        // This action produces 20% of the workflow's progress.
        let resultC = try await execute(GenerateNumericString(iterations: 4, delay: .seconds(1), pendingUnitCount: 20))

        // This action produces 40% of the workflow's progress.
        let resultD = try await execute(GenerateNumericString(iterations: 500, delay: .milliseconds(2), pendingUnitCount: 40))

        return resultA + resultB + resultC + resultD
    }
}

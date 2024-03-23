import SwiftUI

import Hollywood

@MainActor
struct ProgressReportingView: View {

    @State private var result: String = ""
    @State private var contextualActor = ContextualActor<String>()
    @State private var selectedWorkflowOption: WorkflowOption = .stepByStep

    var body: some View {
        VStack {
            Text(result)
            
            Spacer()

            switch contextualActor.state {
            case .ready:
                Text("ready")
            case .busy(_, let progress):
                ProgressView(progress)
            case .success(let value):
                Text(value)
            case .failure(let error, _):
                Text(error.localizedDescription)
            }

            Spacer()

            Picker("Selected Workflow", selection: $selectedWorkflowOption) {
                ForEach(WorkflowOption.allCases, id: \.self) {
                    Text($0.description)
                }
            }

            Button {
                if contextualActor.state.isBusy {
                    contextualActor.cancel()
                } else {
                    contextualActor.execute(selectedWorkflowOption.makeWorkflow())
                }
            } label: {
                Text(contextualActor.state.isBusy ? "Cancel" : "Go")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

extension ProgressReportingView {

    enum WorkflowOption: CustomStringConvertible, CaseIterable {
        case stepByStep
        case stall
        case concurrentSteps
        case taskGroup
        case compositeTaskGroup
        case wonky

        var description: String {
            return switch self {
            case .stepByStep:
                "Step By Step"
            case .stall:
                "Step By Step (Stall)"
            case .concurrentSteps:
                "Concurrent Steps"
            case .taskGroup:
                "Task Group"
            case .compositeTaskGroup:
                "Composite Task Group"
            case .wonky:
                "Wonky"
            }
        }

        func makeWorkflow() -> any WorkflowAction<String> {
            return switch self {
            case .stepByStep:
                StepByStepWorkflow(initialDelay: .seconds(2))
            case .stall:
                StepByStepWithProgressStallWorkflow(initialDelay: .seconds(2))
            case .concurrentSteps:
                ConcurrentStepsWorkflow(initialDelay: .seconds(2))
            case .taskGroup:
                TaskGroupWorkflow()
            case .compositeTaskGroup:
                CompositeTaskGroupWorkflow()
            case .wonky:
                WonkyWorkflow(initialDelay: .seconds(2))
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ProgressReportingView()
}

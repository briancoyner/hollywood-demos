import Foundation

final class Debounced<T: Equatable>: ObservableObject {

    @Published var input: T
    @Published var output: T

    init(input: T, delay: DispatchQueue.SchedulerTimeType.Stride) {
        self.input = input
        self.output = input

        $input
            .removeDuplicates()
            .debounce(for: delay, scheduler: DispatchQueue.main)
            .assign(to: &$output)
    }
}

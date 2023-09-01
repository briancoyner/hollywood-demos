import Foundation
import Combine

@MainActor @Observable
final class Debounced<T: Equatable> {

    @Published @ObservationIgnored
    var input: T

    var output: T

    private var observation: AnyCancellable?

    init(input: T, delay: DispatchQueue.SchedulerTimeType.Stride) {
        self.input = input
        self.output = input

        observation = $input
            .removeDuplicates()
            .debounce(for: delay, scheduler: DispatchQueue.main)
            .assign(to: \.output, on: self)
    }
}

import Foundation

import Hollywood

struct HollywoodImageWorkflowAction: WorkflowAction {

    let urlRequest: URLRequest

    func execute() async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw HollywoodImageError()
        }

        return data
    }
}

extension HollywoodImageWorkflowAction {

    struct HollywoodImageError: Error {
    }
}

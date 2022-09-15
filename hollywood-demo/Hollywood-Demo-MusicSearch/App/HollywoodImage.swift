import SwiftUI

import Hollywood
import HollywoodUI

struct HollywoodImage: View {

    private let urlRequest: URLRequest

    @StateObject
    private var resource = ContextualActor<Data>()

    init(url: URL) {
        self.urlRequest = URLRequest(url: url)
    }

    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
}

extension HollywoodImage {

    var body: some View {
        ContextualActorView(contextualActor: resource) { state in
            switch state {
            case .ready, .busy(_):
                ProgressView()
            case .success(let data):
                Image(uiImage: UIImage(data: data)!)
                    .aspectRatio(1.0, contentMode: .fill)
            case .failure(_, _):
                Image(systemName: "exclamationmark.triangle")
                    .aspectRatio(1.0, contentMode: .fill)
            }
        }
        .task {
            resource.execute(HollywoodImageWorkflowAction(urlRequest: urlRequest))
        }
    }
}

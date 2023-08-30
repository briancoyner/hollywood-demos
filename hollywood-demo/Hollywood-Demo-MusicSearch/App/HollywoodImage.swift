import SwiftUI

import Hollywood

@MainActor
struct HollywoodImage: View {

    private let urlRequest: URLRequest

    @State
    private var contextualActor = ContextualActor<Data>()

    init(url: URL) {
        self.urlRequest = URLRequest(url: url)
    }

    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
}

extension HollywoodImage {

    var body: some View {
        Group {
            switch contextualActor.state {
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
        .onAppear {
            contextualActor.execute(HollywoodImageWorkflowAction(urlRequest: urlRequest))
        }
    }
}

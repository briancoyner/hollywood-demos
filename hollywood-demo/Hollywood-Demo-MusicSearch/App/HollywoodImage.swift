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

    var body: some View {
        ContextualActorView(contextualActor: resource) { data in
            Image(uiImage: UIImage(data: data)!)
                .aspectRatio(1.0, contentMode: .fill)
        }
        .task {
            resource.execute(HollywoodImageWorkflowAction(urlRequest: urlRequest))
        }
    }
}

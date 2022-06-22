# Hollywood Demos

![Header](Hollywood-Demos-Header.png)

The Hollywood Demos repo contains several demo apps showcasing how to build and integrate asynchronous app workflows
using the [Hollywood](https://github.com/briancoyner/hollywood) and [HollywoodUI](https://github.com/briancoyner/hollywood) libraries.  

## Demos
There are 2 demos available (more coming soon):

### GitHub OAuth demo
- [X] Shows how to build an async workflow that authenticates with GitHub. 
  - You'll need to update the `HackGitHubApp` with your GitHub client ID and GitHub client secret. 
    - https://docs.github.com/en/developers/apps/building-github-apps/creating-a-github-app 
  
### iTunes Music Search
- [X] Shows how to build an async workflow that:
  - Uses a `ContextualActor` + `AsyncWorkflowAction` to execute an async HTTP request using `URLSession`.
  - Uses a `ContextualActorView` to update the UI based on the current state of the async workflow.  
  - Presents the search results in a SwiftUI list view.
  - There's also an example showing how to debounce the search text input. 

- [X] Shows how to use a `ContextualActor` and `ContextualActorView` to asynchronously load album art for each search result.
  - Similar to the `AsyncImage` API
  
### SwiftUI Photos Picker (Transferable)
- [ ] _Coming soon_: Show how to integrate the new SwiftUI PhotosPicker to asynchronous transfer a selected photo using a `ContextualActor` and `ContextualActorView`. 

## Requirements
- iOS 16+ (yep, it's leaning on new Swift 5.7 beta features)
- macOS 12+


## Credits

Hollywood Demos is written and maintained by [Brian Coyner](https://briancoyner.github.io).

## License

Hollywood Demos is released under the MIT License.
See [LICENSE](https://github.com/briancoyner/hollywood-demos/blob/master/LICENSE) for details.

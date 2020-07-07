# APIClient

> A clean, generic interface from your application to an API, written in pure Swift with no other dependencies.

> This library is made available as a Swift Package. To use it as a dependency in your project [see this documentation from Apple.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

General usage is as follows:
1. Create your API client
```swift
let client = APIClient("api.github.com")
```
2. Define your requests to the API you are interfacing with (see `Source/Examples/Requests`), and your `Codable` JSON objects to serialize the API's data into (see `Source/Examples/Data Structures`)
3. Instantiate your request, send, and handle the response!
```swift
// Assuming a client named `client` has already been created...
// Create our request (see Source/Examples/Requests/GetPosts.swift)
let request = GetPosts(userId: 1)

// Send request
client.send(request: request, completion: { result in
    switch result {
    case .success(let (response, data)):
    // Handle your data here
    // In this case, data is serialized into a `Post` object (see Source/Examples/Data Structures/Post.swift)
        break
    case .failure(let error):
    // Handle your error here
        break
    }
})
```

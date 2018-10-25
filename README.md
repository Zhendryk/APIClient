# GenericAPIClient
Generic client base class to make asynchronous web requests and decode generic json data

## Installation

There are two options for installing: You can either clone/fork this repository and use the source code yourself, or use cocoapods.

### Cocoapods

If you want to include this in your xcode project using cocoapods, you must do the following:
* Install cocoapods on your computer by running the following command in the terminal:
```
sudo gem install cocoapods
```
You can find further help here: https://guides.cocoapods.org/using/getting-started.html#toc_3
* Create a Podfile using the `pod init` command. Further information on Podfiles can be found here: https://guides.cocoapods.org/using/the-podfile.html
* Point the Podfile to GenericAPIClient, like so:
```
target 'MyApp' do
  use_frameworks!
  pod 'GenericAPIClient'
end
```
* Once you have that Podfile, use the `pod install` command to install the GenericAPIClient dependency into your xcode project. Then enter your project and build it.

A walkthrough of this process can be found here: https://guides.cocoapods.org/using/using-cocoapods

## Usage

There is an example describing all of the options when making an API endpoint for your client. Once you read and understand that, the process is simple:

**Simply create an APIClient object with the base URL of your API like this:**
```swift
let exampleClient: APIClient = APIClient("https://api.example.com/version")
```

**Create an endpoint for it, and you can call for that endpoint like this:**
```swift
_ = exampleClient.send(request: ExampleEndpoint(exampleParameter: 5, exampleExtraPathComponent: "json")) { response in
	switch response {
		case .success(let data):
			// Handle your data here
		case .failure(let error):
			//Handle your error here
	}
}
```

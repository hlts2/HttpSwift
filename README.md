# HttpSwift
HttpSwift is simple http client library for swift

## How to use
Fist, you need to import this library

```swift
import HttpSwift
```

## Basic example

### GET

The most basic request.

```swift

HTTP.Get(url: "https://www.google.co.jp/")
    .do() { result in
        switch result {
        case .success(let value):
            print(value)
        case .failure(let error):
            print(error)
        }
    }

```

We can also add parameters.

```swift

HTTP.Get(url: "https://www.google.co.jp/")
    .setQuery(params: ["a": "1", "b": "2"])
    .do() { result in
        switch result {
        case .success(let value):
            print(value)
        case .failure(let error):
            print(error)
        }
    }

```

We can also add content-type. returned object is json selialized object.

```swift

HTTP.Get(url: "https://www.google.co.jp/")
    .setQuery(params: ["a": "1", "b": "2"])
    .setContentsType(.json)
    .do() { result in
        switch result {
        case .success(let value):
            print(value)        //Json Serialized Object
        case .failure(let error):
            print(error)
        }
    }

```

when reusing request. HTTP instance is singleton object.

```swift

let http = HTTP.instance

```

We can also switch handler type

```swift

//no handler
.do()

//with handler
.do({ result in

})
```

## Request type
All the common HTTTP Method is available

- GET

- POST

```swift

HTTP.Post(url: "https://api.github.com/repos/vmg/redcarpet/")
    .setQuery(params: ["a": "1", "b": "2"])
    .do()

```

- PUT

- DELETE

- PATCH

### Request Cancel
You want to cancel the request. You call cancel method.

```swift
let http = HTTP.instance

http.cancel()
```

### Custom Header
You want to add the custom request header.

```swift
let http = HTTP.instance

http.setHeader(headers: ["test1": "1", "test2": "2"])
```

## Requirements
Swift3.0 or latter.

## Installation

HttpSwift is available through [Carthage](https://github.com/Carthage/Carthage) or
[Swift Package Manager](https://github.com/apple/swift-package-manager).

### Carthage

```
github "hlts2/HttpSwift"
```

for detail, please follow the [Carthage Instruction](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)

### Swift Package Manager

```
dependencies: [
    .Package(url: "https://github.com/hlts2/HttpSwift.git", majorVersion: 1)
]
```

for detail, please follow the [Swift Package Manager Instruction](https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md)

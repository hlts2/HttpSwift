# HttpSwift
HttpSwift is simple http client library for swift

## How to use

### Basic example

```swift
import HttpSwift

HttpSwift.instance
    .get(url: "https://~~~~")
    .do() { response in
        print(response)
    }
```

### Request type

`HttpSwift.instance.get(url: "https://~~~~")`

`HttpSwift.instance.post(url: "https://~~~~")`

`HttpSwift.instance.put(url: "https://~~~~")`

`HttpSwift.instance.delete(url: "https://~~~~")`

`HttpSwift.instance.patch(url: "https://~~~~")`

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

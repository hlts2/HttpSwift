# HttpSwift
HttpSwift is simple http client library for swift

## How to use
Fist, you need to import this library
```swift
import HttpSwift
```

### Basic example

## GET

The most basic request.

```swift

let http = HttpSwift.instance

http.get(url: "https://www.google.co.jp/")
    .do() { response in
        print(response)
    }

```

response type is json

```swift

let http = HttpSwift.instance

http.get(url: "https://api.github.com")
    .setContentsType(.json)
    .do() { response in
        print(response) //print json object
    }

```

### Request type
All the common HTTTP Method is available

## POST

## PUT

## DELETE

## PATCH

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

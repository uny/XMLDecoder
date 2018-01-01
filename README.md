# XMLDecoder

[![Build Status](https://travis-ci.org/uny/XMLDecoder.svg?branch=master)](https://travis-ci.org/uny/XMLDecoder)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Codecov](https://img.shields.io/codecov/c/github/uny/XMLDecoder.svg)](https://travis-ci.org/uny/XMLDecoder)

XMLDecoder for Swift.

## Requirements

- iOS 8.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

### Carthage

To integrate XMLDecoder into your Xcode project using Carthage, specify it in your `Cartfile`:
```
github "uny/XMLDecoder"
```

## Usage
You can use XMLDecoder like JSONDecoder:
```swift
struct Object {
  let string: String
  let int: Int
}

let data = "<root><string>string</string><int>100</int></root>".data(using: .utf8)!
let decoder = XMLDecoder()
do {
  let object = try decoder.decode(Object.self, from: data)
  print(object)
} catch let error {
  // ...
}
```
XMLDecoder currently does not support attributes.

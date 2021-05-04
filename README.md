# SwiftyHeap

[![CI Status](https://img.shields.io/travis/BillMcCann/SwiftyHeap.svg?style=flat)](https://travis-ci.org/BillMcCann/SwiftyHeap)
[![Version](https://img.shields.io/cocoapods/v/SwiftyHeap.svg?style=flat)](https://cocoapods.org/pods/SwiftyHeap)
[![License](https://img.shields.io/cocoapods/l/SwiftyHeap.svg?style=flat)](https://cocoapods.org/pods/SwiftyHeap)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyHeap.svg?style=flat)](https://cocoapods.org/pods/SwiftyHeap)

## Example

```swift
  import SwiftyHeap

  // Initialize a new MinHeap instance.
  let minHeap = MinHeap<Int>()
  
  // Inserting a single element:
  minHeap.insert(9) // inserts "9" into the heap
  var count = minHeap.count() // "1"
  var min = minHeap.peekMin() // "9"
  
  // Inserting an array of elements:
  let arrayToInsert: [Int] = [2,5,4,-1,7]
  minHeap.insert(arrayToInsert)
  count = minHeap.count() // "6"
  
  // Extracting minimal element from heap:
  min = minHeap.extractMin() // removes and returns "-1"
  count = minHeap.count() // "5"
  min = minHeap.peekMin() // "2"
```

## Requirements

SwiftyHeap was written for Swift 5. SwiftyHeap may or may not work with earlier versions of Swift, and has not been tested with them.

## Installation

SwiftyHeap is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyHeap'
```

## Author

Bill McCann

## License

SwiftyHeap is available under the MIT license. See the LICENSE file for more info.

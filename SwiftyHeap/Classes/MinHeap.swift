import Foundation

class MinHeap<T: Comparable> {
  private var heap = [T]()
  
  func insert(_ element: T) {
    heap.append(element)
    let lastIndex = heap.count - 1
    heapify(lastIndex)
  }
  
  func insert(_ elements: [T]) {
    for element in elements {
      self.insert(element)
    }
  }
  
  func extractMin() -> T {
    heap.swapAt(heap.startIndex, heap.endIndex - 1)
    let result = heap.popLast()!
    downHeapify()
    return result
  }
  
  func peekMin() -> T {
    return heap.first!
  }
  
  func heapSort() {
    var startIndex = heap.count - 1
    while startIndex > 0 {
      heapify(startIndex)
      startIndex -= 1
    }
  }
  
  func count() -> Int {
    return heap.count
  }
  
  // MARK: Private Methods
  private func heapify(_ position: Int) {
    if position < 0 {return}
    let lastIndex = heap.count  - 1
    let leftChildPosition = getLeftIndex(position)
    let rightChildPosition = getRightIndex(position)
    if leftChildPosition <= lastIndex {
      if rightChildPosition <= lastIndex {
        let rightChildIsLess = heap[rightChildPosition] < heap[leftChildPosition]
        if rightChildIsLess && heap[rightChildPosition] < heap[position] {
          heap.swapAt(position, rightChildPosition)
        } else {
          if heap[leftChildPosition] < heap[position] {
            heap.swapAt(leftChildPosition, position)
          }
        }
      } else {
        if heap[leftChildPosition] < heap[position] {
          heap.swapAt(leftChildPosition, position)
        }
      }
    }
    if position != 0 {
      let parentIndex = getParentIndex(position)
      heapify(parentIndex)
    }
  }
  
  private func downHeapify() {
    self.downHeapify(0)
  }
  
  private func downHeapify(_ position: Int) {
    if position >= heap.count {return}
    let lastIndex = heap.count  - 1
    let leftChildPosition = getLeftIndex(position)
    let rightChildPosition = getRightIndex(position)
    var leftChildSwapped: Bool? = nil
    if leftChildPosition <= lastIndex {
      if rightChildPosition <= lastIndex {
        let rightChildIsLess = heap[rightChildPosition] < heap[leftChildPosition]
        if rightChildIsLess && heap[rightChildPosition] < heap[position] {
          heap.swapAt(position, rightChildPosition)
          leftChildSwapped = false
        } else {
          if heap[leftChildPosition] < heap[position] {
            heap.swapAt(leftChildPosition, position)
            leftChildSwapped = true
          }
        }
      } else {
        if heap[leftChildPosition] < heap[position] {
          heap.swapAt(leftChildPosition, position)
          leftChildSwapped = true
        }
      }
    }
    if leftChildSwapped != nil {
      let childPosition = leftChildSwapped! ? leftChildPosition : rightChildPosition
      downHeapify(childPosition)
    }
  }
  
  private func getLeftIndex(_ position: Int) -> Int {
    return 2*position + 1
  }
  private func getRightIndex(_ position: Int) -> Int {
    return 2*position + 2
  }
  private func getParentIndex(_ position: Int) -> Int {
    return (position - 1)/2
  }

  // MARK: Testing Methods
  func isProper() -> Bool {
    return isProperHeap(0)
  }
  
  private func isProperHeap(_ position: Int) -> Bool {
    if position >= heap.count {return true} // parent was leaf
    let leftIndex = getLeftIndex(position)
    let rightIndex = getRightIndex(position)
    var childValuesValid = true
    if leftIndex < heap.count {
      if rightIndex < heap.count {
        if heap[rightIndex] < heap[position] {childValuesValid = false}
      }
      if heap[leftIndex] < heap[position] {childValuesValid = false}
    }
    
    let childrenAreHeaps = isProperHeap(leftIndex) && isProperHeap(rightIndex)
    return childValuesValid && childrenAreHeaps
  }
}


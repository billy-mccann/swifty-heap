import Foundation

// MARK: - MaxHeap
/** MaxHeap is an implementation of the heap data structure with the property that each node is greater than its children, recursively. */
class MaxHeap<T: Comparable>: Heap<T> {
  init() {
    super.init(>)
  }
  
  /** Removes and returns the maximal element of the heap. */
  func extractMax() -> T {
    return super.extract()
  }
  
  /** Returns the maximal element of the heap. */
  func peekMax() -> T {
    return super.peek()
  }
}

// MARK: - MinHeap
/** MinHeap is an implementation of the heap data structure with the property that each node is less than its children, recursively. */
class MinHeap<T: Comparable>: Heap<T> {
  init() {
    super.init(<)
  }
  
  /** Removes and returns the minimal element of the heap. */
  func extractMin() -> T {
    return super.extract()
  }
  
  /** Returns the minimal element of the heap. */
  func peekMin() -> T {
    return super.peek()
  }
}

// MARK: - Heap
class Heap<T: Comparable> {
  private var heap = [T]()
  private let comparator: (T,T) -> Bool
  /** Returns the number of elements in the heap. */
  private(set) var count:Int = 0
  
  init(_ comparator: @escaping (T,T) -> Bool) {
    self.comparator = comparator
  }
  
  /** Inserts a single element  into the heap. */
  func insert(_ element: T) {
    self.heap.append(element)
    self.count += 1
    upHeapify(comparator)
  }
  
  /** Inserts an array of elements into the heap. */
  func insert(_ elements: [T]) {
    for element in elements {
      self.insert(element)
    }
  }
  
  /** Removes and returns the maximal(minimal) element of the heap. */
  fileprivate func extract() -> T {
    self.heap.swapAt(heap.startIndex, heap.endIndex - 1)
    self.count -= 1
    let result = self.heap.popLast()!
    downHeapify(comparator)
    return result
  }
  
  /** Returns the maximal(minimal) element of the heap. */
  fileprivate func peek() -> T {
    return self.heap.first!
  }
  
  // MARK: - Private Methods
  private func upHeapify(_ comparator: (T,T) -> Bool) {
    heapify(position: self.count - 1, comparator: comparator, upheapify: true)
  }
  
  private func downHeapify(_ comparator: (T,T) -> Bool) {
    self.heapify(position: 0, comparator: comparator, upheapify: false)
  }
  
  /** Used for both upHeapify and downHeapify: behavior is determined by the "upheapify" parameter. */
  private func heapify(position: Int, comparator: (T,T) -> Bool, upheapify: Bool) {
    /* upHeapify starts at the last index and finishes at 0. downHeapify does the opposite. */
    if upheapify {
      if position < 0 {return}
    } else {
      if position >= self.count {return}
    }
    
    /*
     The middle code for heapify is identical for upHeapify and downHeapify: ensure that the heap
     condition is fulfilled for the current node and its children.
     */
    let lastIndex = self.count - 1
    let leftChildPosition = getLeftIndex(position)
    let rightChildPosition = getRightIndex(position)
    // leftChildSwapped only used for downHeapify. False -> Right child swapped. Nil -> no swap occurred.
    var leftChildSwapped: Bool? = nil
    if leftChildPosition <= lastIndex {
      if rightChildPosition <= lastIndex {
        let rightChildIsGreater = comparator(heap[rightChildPosition], heap[leftChildPosition])
        if rightChildIsGreater && comparator(heap[rightChildPosition], heap[position]) {
          heap.swapAt(position, rightChildPosition)
          leftChildSwapped = false
        } else {
          if comparator(heap[leftChildPosition], heap[position]) {
            heap.swapAt(leftChildPosition, position)
            leftChildSwapped = true
          }
        }
      } else {
        if comparator(heap[leftChildPosition], heap[position]) {
          heap.swapAt(leftChildPosition, position)
          leftChildSwapped = true
        }
      }
    }
    
    // For each direction, decide if we need to continue the heapify routine.
    if upheapify {
      if position != 0 {
        let parentPosition = getParentIndex(position)
        heapify(position: parentPosition, comparator: comparator, upheapify: upheapify)
      }
    } else {
      // leftChildSwapped: True -> Left child swapped. False -> Right child swapped. Nil -> no swap occurred.
      if leftChildSwapped != nil {
        let childPosition = leftChildSwapped! ? leftChildPosition : rightChildPosition
        heapify(position: childPosition, comparator: comparator, upheapify: upheapify)
      }
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
}

// MARK: - Testing Methods
extension Heap {
  /** Returns true if the heap is properly formed, false otherwise. */
  func isProper() -> Bool {
    return isProperHeap(0)
  }
  
  /** Helper function wrapped by isProper(). */
  private func isProperHeap(_ position: Int) -> Bool {
    if position >= self.count {return true} // parent was leaf
    let leftIndex = getLeftIndex(position)
    let rightIndex = getRightIndex(position)
    var childValuesValid = true
    if leftIndex < self.count {
      if rightIndex < self.count {
        if comparator(heap[rightIndex], heap[position]) {childValuesValid = false}
      }
      if comparator(heap[leftIndex], heap[position]) {childValuesValid = false}
    }
    
    let childrenAreHeaps = isProperHeap(leftIndex) && isProperHeap(rightIndex)
    return childValuesValid && childrenAreHeaps
  }
}
